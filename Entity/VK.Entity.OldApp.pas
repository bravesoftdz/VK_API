unit VK.Entity.OldApp;

interface

uses
  Generics.Collections, Rest.Json;

type
  TVkOldApp = class
  private
    FId: Extended;
    FPhoto_604: string;
    FPhoto_130: string;
    FName: string;
  public
    property Id: Extended read FId write FId;
    property Name: string read FName write FName;
    property Photo130: string read FPhoto_130 write FPhoto_130;
    property Photo604: string read FPhoto_604 write FPhoto_604;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TVkOldApp;
  end;

implementation

{TVkOldApp}

function TVkOldApp.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TVkOldApp.FromJsonString(AJsonString: string): TVkOldApp;
begin
  result := TJson.JsonToObject<TVkOldApp>(AJsonString)
end;

end.

