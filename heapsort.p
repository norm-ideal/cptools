type tArrayItem = record
  value : int64;
end;

var a : array[1..100] of tArrayItem;
    n : integer;

function larger(a1, a2 : int64) : boolean; inline;
begin
  result := (a[a1].value>a[a2].value);
end;

procedure swap(i,j : int64); inline;
var tmp : tArrayItem;
begin
  tmp := a[i];
  a[i] := a[j];
  a[j] := tmp;
end;

procedure drop(p : int64; bottom : int64);
var p1,p2 : int64;
begin
  p1 := p*2;
  p2 := p*2+1;
  if p1>bottom then exit;
  if p2>bottom then begin
    if larger(p1,p) then begin
      swap(p1,p);
      drop(p1, bottom);
    end;
    exit;
  end;

  if larger(p1,p2) then begin
    if larger(p1,p) then begin
      swap(p1,p);
      drop(p1, bottom);
      exit;
    end;
  end else begin
    if larger(p2,p) then begin
      swap(p2,p);
      drop(p2, bottom);
      exit;
    end;
  end;
end;


procedure hsort(n : int64);
var i : int64;
    ht : int64;
begin
  if n<2 then exit;

  ht := n div 2;
  for i:=ht downto 1 do begin
    drop(i,n);
  end;

  for i:=n downto 2 do begin
    swap(1,i);
    drop(1,i-1);
  end;
end;

var i : integer;

begin
  n:=100;
  for i:=1 to n do begin
    a[i].value := round(random() * 100);
  end;

  writeln('---');
  for i:=1 to n do begin
    writeln( a[i].value );
  end;

  hsort(n);

  writeln('---');
  for i:=1 to n do begin
    writeln( a[i].value );
  end;
end.
