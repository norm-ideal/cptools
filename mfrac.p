{ ***** begin of MFRAC *********************************** }
  type mfrac = class
  private
//    procedure clean;
  protected

  public
    y,x : int64;
    modulus : int64; static;
    constructor Create; overload;
    constructor Create(u,b : int64); overload;
    destructor Destroy; override;
    procedure print;
    procedure println;
    procedure let(u,b : int64);
    procedure add( f : mfrac );
    function getmod : int64;
    function iszero : boolean;
  published

  end;

// in modulusr, 0/1 does not mean probability zero.
// we use 0/0 for exact zero

  constructor mfrac.Create;
  begin
    Create(0,0);
  end;

  constructor mfrac.Create(u,b : int64);
  begin
    let(u mod modulus,b mod modulus);
  end;

  destructor mfrac.Destroy;
  begin

  end;

  function mfrac.iszero : boolean; inline;
  begin
    result := (x=0);
  end;

{ // modulusr なので割り算禁止！
  procedure mfrac.clean;
  var dy, dx, tmp : int64;
  begin
    dy := y;
    dx := x;
    if dy>dx then dy:=dy mod dx;
    while dy<>0 do begin
      tmp := dx mod dy;
      dx := dy;
      dy := tmp;
    end;
    y := y div dx;
    x := x div dx;
  end;
}

  procedure mfrac.let(u,b : int64); inline;
  begin
    y := u mod modulus;
    x := b mod modulus;
  end;

  procedure mfrac.print;
  begin
    write(y, '/', x);
  end;

  procedure mfrac.println;
  begin
    print;
    writeln;
  end;

  procedure mfrac.add( f : mfrac ); inline;
  begin
    if iszero then begin
      y := f.y;
      x := f.x;
    end else if f.iszero then begin
      exit;
    end else begin
      y := ((y * f.x) mod modulus + (f.y * x) mod modulus) mod modulus;
      x := (x * f.x) mod modulus;
    end;
  end;

  function mfrac.getmod : int64; inline;
  var pw,nn : int64;
  begin
    result := 0;
    if modulus=0 then exit;

    pw := modulus - 2;
    result := y;
    nn := x;
    while pw>0 do begin
      if pw and $01=1 then begin
        result := (result * nn) mod 998244353;
      end;
      nn := (nn * nn) mod 998244353;
      pw := pw shr 1;
    end;
  end;
{ ***** end of MFRAC *********************************** }

