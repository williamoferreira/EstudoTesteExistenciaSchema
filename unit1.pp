unit Unit1;

{$mode objfpc}{$H+}

interface

uses
	Classes, SysUtils, mysql57conn, SQLDB, Forms, Controls, Graphics, Dialogs,
	StdCtrls;

type

	{ TForm1 }

	TForm1 = class(TForm)
		MySQL57Connection1: TMySQL57Connection;
		SQLTransaction1: TSQLTransaction;
		procedure FormCreate(Sender: TObject);
	private

	public

	end;

var
	Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
var
	lista: TStringList;
	agre: string;
	i: integer;
begin
	try
		agre := '';
		MySQL57Connection1.Connected := True;
		lista := TStringList.Create;
		lista.Sorted := False;
		MySQL57Connection1.GetSchemaNames(lista);
		for i := 0 to lista.Count - 1 do
			agre := agre + i.ToString + ' - ' + lista.Strings[i] + chr(13);
		ShowMessage(agre);
		lista.Sort;
		lista.Sorted := True;
		if lista.Find('sis_consultorio', i) then
		begin
      MySQL57Connection1.Connected := false;
			MySQL57Connection1.DatabaseName := 'sis_consultorio';
      MySQL57Connection1.Connected := true;
			MySQL57Connection1.GetTableNames(lista);
      agre := '';
			for i := 0 to lista.Count - 1 do
				agre := agre + i.ToString + ' - ' + lista.Strings[i] + chr(13);
			ShowMessage(agre);
		end;
	except
		on e: Exception do
			ShowMessage(e.ClassName);
	end;
end;

end.

