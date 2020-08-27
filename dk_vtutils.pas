unit DK_VTUtils;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, VirtualTrees, DK_Vector, DK_Matrix;

  procedure VTVerifyAllChecking(const ACheckColumnIndex: Integer;
                              const AVT: TVirtualStringTree; const AFlagVector: TBoolVector);
  procedure VTVerifyAllChecking(const ACheckColumnIndex: Integer;
                              const AVT: TVirtualStringTree; const AFlagMatrix: TBoolMatrix);
  procedure VTHeaderChecking(const ACheckColumnIndex: Integer;
                           const AVT: TVirtualStringTree; const AHitInfo: TVTHeaderHitInfo;
                           var AFlagVector: TBoolVector);
  procedure VTHeaderChecking(const ACheckColumnIndex: Integer;
                           const AVT: TVirtualStringTree; const AHitInfo: TVTHeaderHitInfo;
                           var AFlagMatrix: TBoolMatrix);
  procedure VTExpandOnHeaderClick(const AVT: TVirtualStringTree);
  procedure VTRowChecking(const AVT: TVirtualStringTree;
                       const Node: PVirtualNode; const NewState: TCheckState;
                       var AFlagVector: TBoolVector;
                       const ACheckColumnIndex: Integer = -1);
  procedure VTRowChecking(const AVT: TVirtualStringTree;
                       const Node: PVirtualNode; const NewState: TCheckState;
                       var AFlagMatrix: TBoolMatrix;
                       const ACheckColumnIndex: Integer = -1);
  procedure VTLoad(const AVT: TVirtualStringTree; const AVector: TStrVector);
  procedure VTLoad(const AVT: TVirtualStringTree; const AMatrix: TStrMatrix;
                   const AExpandNode: Boolean = True);
  procedure VTLoad(const AVT: TVirtualStringTree; const AMatrix: TStrMatrix;
                   const AExpandNodeIndex: Integer = -1);
  function VTShowNode(const AVT: TVirtualStringTree; const AInd1, AInd2: Integer): PVirtualNode;

implementation

function GetCheckState(const AIsAllChecked, AIsAllUnchecked: Boolean): TCheckState;
begin
  if AIsAllChecked then Result:= csCheckedNormal else
    if AIsAllUnchecked then Result:= csUncheckedNormal else
      Result:= csMixedNormal;
end;

procedure VTVerifyAllChecking(const ACheckColumnIndex: Integer;
                           const AVT: TVirtualStringTree; const AFlagVector: TBoolVector);
var
  i: Integer;
  IsAllChecked, IsAllUnchecked: Boolean;
begin
  if Length(AFlagVector)=0 then
  begin
    AVT.Header.Columns[ACheckColumnIndex].CheckState:= csUncheckedNormal;
    Exit;
  end;
  IsAllChecked:= True;
  IsAllUnchecked:= True;
  for i:=0 to High(AFlagVector) do
    if AFlagVector[i] then IsAllUnchecked:= False else IsAllChecked:= False;
  AVT.Header.Columns[ACheckColumnIndex].CheckState:= GetCheckState(IsAllChecked, IsAllUnchecked);;
  AVT.Refresh;
end;

procedure VTVerifyAllChecking(const ACheckColumnIndex: Integer;
                            const AVT: TVirtualStringTree; const AFlagMatrix: TBoolMatrix);
var
  i,j: Integer;
  IsAllChecked, IsAllUnchecked: Boolean;
begin
  if Length(AFlagMatrix)=0 then
  begin
    AVT.Header.Columns[ACheckColumnIndex].CheckState:= csUncheckedNormal;
    Exit;
  end;
  IsAllChecked:= True;
  IsAllUnchecked:= True;
  for i:=0 to High(AFlagMatrix) do
    for j:= 0 to High(AFlagMatrix[i]) do
      if AFlagMatrix[i,j] then IsAllUnchecked:= False else IsAllChecked:= False;
  AVT.Header.Columns[ACheckColumnIndex].CheckState:= GetCheckState(IsAllChecked, IsAllUnchecked);
  AVT.Refresh;
end;

procedure VTHeaderChecking(const ACheckColumnIndex: Integer;
                           const AVT: TVirtualStringTree; const AHitInfo: TVTHeaderHitInfo;
                           var AFlagVector: TBoolVector);
var
  C: TCheckState;
  i: Integer;
  Node: PVirtualNode;
begin
  if (AHitInfo.Column=ACheckColumnIndex) and (hhiOnCheckbox in AHitInfo.HitPosition ) then
  begin
    C:= AVT.Header.Columns[ACheckColumnIndex].CheckState;
    if C in [csCheckedNormal, csUncheckedNormal] then
    begin
      Node:= AVT.GetFirstChild(AVT.RootNode);
      while Node<>nil do
      begin
        Node^.CheckState := C;
        i:= Node^.Index;
        AFlagVector[i]:= C=csCheckedNormal;
        Node:= AVT.GetNextSibling(Node);
      end;
    end;
  end;
  AVT.Refresh;
end;

procedure VTHeaderChecking(const ACheckColumnIndex: Integer;
                           const AVT: TVirtualStringTree; const AHitInfo: TVTHeaderHitInfo;
                           var AFlagMatrix: TBoolMatrix);
var
  C: TCheckState;
  i,j: Integer;
  Node1, Node2: PVirtualNode;
begin
  if (AHitInfo.Column=ACheckColumnIndex) and (hhiOnCheckbox in AHitInfo.HitPosition ) then
  begin
    C:= AVT.Header.Columns[ACheckColumnIndex].CheckState;
    if C in [csCheckedNormal, csUncheckedNormal] then
    begin
      Node1:= AVT.GetFirstChild(AVT.RootNode);
      while Node1<>nil do
      begin
        Node1^.CheckState := C;
        i:= Node1^.Index;
        Node2:= AVT.GetFirstChild(Node1);
        while Node2<>nil do
        begin
          Node2^.CheckState := C;
          j:= Node2^.Index;
          AFlagMatrix[i,j]:= C=csCheckedNormal;
          Node2:= AVT.GetNextSibling(Node2);
        end;
        Node1:= AVT.GetNextSibling(Node1);
      end;
    end;
  end;
  AVT.Refresh;
end;

procedure VTExpandOnHeaderClick(const AVT: TVirtualStringTree);
var
  Node: PVirtualNode;
begin
  AVT.Tag:=Ord((AVT.Tag=0));
  Node:= AVT.GetFirstChild(AVT.RootNode);
  while Node<>nil do
  begin
    AVT.Expanded[Node]:= AVT.Tag=1;
    Node:= AVT.GetNext(Node);
  end;
end;

procedure VTRowChecking(const AVT: TVirtualStringTree;
                      const Node: PVirtualNode; const NewState: TCheckState;
                      var AFlagVector: TBoolVector;
                      const ACheckColumnIndex: Integer = -1);
var
  i, Level: Integer;
begin
  Level:= AVT.GetNodeLevel(Node);
  if Level=0 then
  begin
    i:= Node^.Index;
    if NewState=csUncheckedNormal then
      AFlagVector[i]:= False
    else if NewState=csCheckedNormal then
      AFlagVector[i]:= True;
    if ACheckColumnIndex>=0 then
      VTVerifyAllChecking(ACheckColumnIndex, AVT, AFlagVector);
  end;
end;

procedure VTRowChecking(const AVT: TVirtualStringTree;
                     const Node: PVirtualNode; const NewState: TCheckState;
                     var AFlagMatrix: TBoolMatrix;
                     const ACheckColumnIndex: Integer = -1);
var
  i,j, Level: Integer;
begin
  Level:= AVT.GetNodeLevel(Node);
  if Level=0 then
  begin
    i:= Node^.Index;
    if NewState=csUncheckedNormal then
      for j:= 0 to High(AFlagMatrix[i]) do
        AFlagMatrix[i,j]:= False
    else if NewState=csCheckedNormal then
      for j:= 0 to High(AFlagMatrix[i]) do
        AFlagMatrix[i,j]:= True;
  end
  else begin
    i:= (Node^.Parent)^.Index;
    j:= Node^.Index;
    if NewState=csUncheckedNormal then
      AFlagMatrix[i,j]:= False
    else if NewState=csCheckedNormal then
      AFlagMatrix[i,j]:= True;
  end;
  if ACheckColumnIndex>=0 then
    VTVerifyAllChecking(ACheckColumnIndex, AVT, AFlagMatrix);
end;

procedure VTLoad(const AVT: TVirtualStringTree; const AVector: TStrVector);
var
  i: Integer;
begin
  AVT.Clear;
  for i:= 0 to High(AVector) do
    AVT.AddChild(AVT.RootNode);
end;

procedure VTLoad(const AVT: TVirtualStringTree; const AMatrix: TStrMatrix;
                 const AExpandNode: Boolean = True);
var
  i,j: Integer;
  Node: PVirtualNode;
begin
  AVT.Clear;
  for i:= 0 to High(AMatrix) do
  begin
    Node := AVT.AddChild(AVT.RootNode);
    for j:= 0 to High(AMatrix[i]) do AVT.AddChild(Node);
    AVT.Expanded[Node]:= AExpandNode;
  end;
end;

procedure VTLoad(const AVT: TVirtualStringTree; const AMatrix: TStrMatrix;
                 const AExpandNodeIndex: Integer = -1);
var
  i,j: Integer;
  Node: PVirtualNode;
begin
  AVT.Clear;
  for i:= 0 to High(AMatrix) do
  begin
    Node := AVT.AddChild(AVT.RootNode);
    for j:= 0 to High(AMatrix[i]) do AVT.AddChild(Node);
    AVT.Expanded[Node]:= i=AExpandNodeIndex;
  end;
end;

function VTShowNode(const AVT: TVirtualStringTree; const AInd1, AInd2: Integer): PVirtualNode;
var
  i,j: Integer;
  Node: PVirtualNode;
begin
  Result:= nil;
  Node:= AVT.GetFirst;
  while Assigned(Node) do
  begin
    if AVT.GetNodeLevel(Node)=1 then
    begin
      i:= (Node^.Parent)^.Index;
      j:= Node^.Index;
      if (i=AInd1) and (j=AInd2) then
      begin
        AVT.Expanded[Node^.Parent]:= True;
        AVT.FocusedNode:= Node;
        Result:= Node;
        break;
      end;
    end;
    Node:= AVT.GetNext(Node);
  end;
end;

end.

