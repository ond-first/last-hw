unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls;

const
  delta = 30;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Timer1: TTimer;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);

  private

  public

  end;

var
  Form1: TForm1;
  deltaX, deltaY, deltaEll : integer;
  angle : integer;
  flagreverse, flagRevEll: boolean;

implementation

{$R *.lfm}

{ TForm1 }


function RandomColor(): TColor;
begin
  Randomize;

  Result := RGBToColor(Random(256), Random(256), Random(256));
end;

procedure ClearScreen(Canvas: TCanvas);
begin
     Canvas.Brush.Color := RandomColor;
     Canvas.Clear;
     Canvas.Clear;
end;

procedure rotate(var x : integer; var y : integer; angle : double);
var
  xbuf : double;
  rangle : double;
begin
   rangle := angle * pi / 180;
   xbuf := x * cos(rangle) + y * sin(rangle);
   y := Trunc(-x * sin(rangle) + y * cos(rangle));
   x := Trunc(xbuf);
end;



procedure DrawPic(Canvas: TCanvas);
var
  x, y: integer;
begin
     ClearScreen(Canvas);

     Canvas.Pen.Color := clRed;
     Canvas.Pen.Width := 4;

     x := 150;
     y := 150;
     rotate(x, y, angle);

     Canvas.Line(0 + deltaX, 0 + deltaY, x + deltaX, y + deltaY);

     Canvas.Brush.Color := RandomColor;
     Canvas.Pen.Color := clBlue;
     Canvas.Pen.Width := 2;
     Canvas.Pen.Style := psSolid;
     Canvas.Ellipse(x - 50 + deltaX, y - 50 + deltaY, x + 50 + deltaX, y + 50 + deltaY);

     Canvas.Brush.Color := RandomColor;
     Canvas.Ellipse(0 + deltaEll, 300, 200 + deltaEll, 500);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
     flagreverse := False;
     flagRevEll := False;
     deltaEll := 0;
     timer1.Enabled := True;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  deltaX := deltaX - delta;
  DrawPic(Canvas);
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  deltaX := deltaX + delta;
  DrawPic(Canvas);
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  deltaY := deltaY + delta;
  DrawPic(Canvas);
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  deltaY := deltaY - delta;
  DrawPic(Canvas);
end;


procedure TForm1.Button6Click(Sender: TObject);
begin
   angle := angle - delta;
   DrawPic(Canvas);
end;

procedure TForm1.Button7Click(Sender: TObject);
begin
   angle := angle + delta;
   DrawPic(Canvas);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  deltaX := 0;
  deltaY := 0;
  angle := 0;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  if angle > 45 then
     flagreverse := True
  else if angle < -135 then
     flagreverse := False;

  if flagreverse then
     angle := angle - 5
  else
    angle := angle + 5;


  if 200 + deltaEll > Width then
     flagRevEll := True
  else if deltaEll < 0 then
     flagRevEll := False;

  if flagRevEll then
     deltaEll := deltaEll - 20
  else
    deltaEll := deltaEll + 20;

  DrawPic(Canvas);
end;

end.


























