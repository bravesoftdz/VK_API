# VKAPI
 VK API

Русский
-
API для Вконтакте

Способы авторизации:
Авторизация через OAuth2 форму

    VK1.Login(Self);
Авторизация напрямую, используя токен (пользовательский или бота)
    
    procedure TFormMain.VKAuth(Sender: TObject; var Token: string; var TokenExpiry: Int64; var ChangePasswordHash: string);
    begin
      Token := '<здесь токен>';
    end;
    procdure TFormMain.FormCreate(Sender: TObject);
    begin
      VK.Login;
      
 







Получение пользователей:

    var
      Users: TVkUsers;
      i: Integer;
    begin
      if VK1.Users.Get(Users, '286400863,415730216', UserFieldsAll, '') then
      begin
        for i := Low(Users.Items) to High(Users.Items) do
        begin
          Memo1.Lines.Add('About: ' + Users.Items[i].About);
          Memo1.Lines.Add('BirthDate: ' + Users.Items[i].BirthDate);
          Memo1.Lines.Add('Books: ' + Users.Items[i].Books);
          Memo1.Lines.Add('Domain: ' + Users.Items[i].Domain);
          Memo1.Lines.Add('FirstName: ' + Users.Items[i].FirstName);
          Memo1.Lines.Add('Movies: ' + Users.Items[i].Movies);
          Memo1.Lines.Add('------------');
        end;
        Users.Free;
      end;
    end;



**English**
-
API for Vkontakte
> *I just began*

Call authorization form

    VK1.Login(Self);

<!--stackedit_data:
eyJoaXN0b3J5IjpbMTExNDg0NzM1NywzNDUyOTIzNSwtMTQ0NT
E4MDc0MV19
-->