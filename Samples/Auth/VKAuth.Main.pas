unit VKAuth.Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, VK.API, VK.Components, Vcl.ExtCtrls, VK.Handler,
  Vcl.StdCtrls;

type
  TFormMain = class(TForm)
    VK1: TVK;
    LabelLogin: TLabel;
    Memo1: TMemo;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    procedure FormCreate(Sender: TObject);
    procedure VK1Login(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
  private
  public
    { Public declarations }
  end;

var
  FormMain: TFormMain;

implementation

uses
  VK.Account.Info, VK.Types, VK.Account.ProfileInfo, VK.Account.ActiveOffers, VK.Account.Counters,
  VK.Account.PushSettings;

{$R *.dfm}

procedure TFormMain.Button1Click(Sender: TObject);
begin
  if VK1.Account.Ban(-1) then
    Memo1.Lines.Add('Banned')
  else
    Memo1.Lines.Add('Error banned');
end;

procedure TFormMain.Button2Click(Sender: TObject);
begin
  if VK1.Account.UnBan(-1) then
    Memo1.Lines.Add('Unbanned')
  else
    Memo1.Lines.Add('Error unbanned');
end;

procedure TFormMain.Button3Click(Sender: TObject);
var
  Offers: TActiveOffers;
  i: Integer;
begin
  if VK1.Account.GetActiveOffers(Offers, 0) then
  begin
    Memo1.Lines.Add('ActiveOffers ' + Offers.count.ToString);
    for i := 0 to Length(Offers.items) - 1 do
    begin
      Memo1.Lines.Add('--');
      Memo1.Lines.Add(Offers.items[i].description);
    end;
    Offers.Free;
  end;
end;

procedure TFormMain.Button4Click(Sender: TObject);
var
  Perm: Int64;
begin
  if VK1.Account.GetAppPermissions(Perm, 58553419) then
    Memo1.Lines.Add(Perm.ToString);
end;

procedure TFormMain.Button5Click(Sender: TObject);
var
  Counters: TCountersClass;
begin
  if VK1.Account.GetCounters(Counters) then
  begin
    Memo1.Lines.Add('messages ' + Counters.messages.ToString);
    Memo1.Lines.Add('notifications ' + Counters.notifications.ToString);
    Counters.Free;
  end;
end;

procedure TFormMain.Button6Click(Sender: TObject);
var
  PushSettings: TPushSettingsClass;
begin
  if VK1.Account.GetPushSettings(PushSettings, '1') then
  begin
    Memo1.Lines.Add('disabled ' + PushSettings.disabled.ToString);
    Memo1.Lines.Add('conversations ' + PushSettings.conversations.count.ToString);
    PushSettings.Free;
  end;
end;

procedure TFormMain.Button7Click(Sender: TObject);
var
  Response: TResponse;
  Info: TProfileInfoData;
begin
  Info.status := 'test1';
  if VK1.Account.SaveProfileInfo(Info, Response) then
    Memo1.Lines.Add(Response.Value);
end;

procedure TFormMain.FormCreate(Sender: TObject);
begin
  VK1.Login(Self);
end;

procedure TFormMain.VK1Login(Sender: TObject);
var
  Info: TProfileInfoClass;
begin
  LabelLogin.Caption := 'login';

  if VK1.Account.GetProfileInfo(Info) then
  begin
    Memo1.Lines.Add(Info.country.title);
    Memo1.Lines.Add(Info.relation_partner.first_name);
    Info.Free;
  end;
end;

end.

