unit VK.Entity.Audio;

interface

uses
  Generics.Collections, System.SysUtils, Rest.Json, System.Json, VK.Types;

type
  TVkAudioArtist = class
  private
    FDomain: string;
    FId: string;
    FName: string;
  public
    property Domain: string read FDomain write FDomain;
    property Id: string read FId write FId;
    property Name: string read FName write FName;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TVkAudioArtist;
  end;

  TVkAlbumThumb = class
  private
    FHeight: Extended;
    FPhoto_135: string;
    FPhoto_270: string;
    FPhoto_300: string;
    FPhoto_34: string;
    FPhoto_600: string;
    FPhoto_68: string;
    FWidth: Extended;
  public
    property Height: Extended read FHeight write FHeight;
    property Width: Extended read FWidth write FWidth;
    property Photo135: string read FPhoto_135 write FPhoto_135;
    property Photo270: string read FPhoto_270 write FPhoto_270;
    property Photo300: string read FPhoto_300 write FPhoto_300;
    property Photo34: string read FPhoto_34 write FPhoto_34;
    property Photo600: string read FPhoto_600 write FPhoto_600;
    property Photo68: string read FPhoto_68 write FPhoto_68;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TVkAlbumThumb;
  end;

  TVkAudioAlbum = class
  private
    FAccess_key: string;
    FId: Extended;
    FOwner_id: Extended;
    FThumb: TVkAlbumThumb;
    FTitle: string;
  public
    property AccessKey: string read FAccess_key write FAccess_key;
    property Id: Extended read FId write FId;
    property OwnerId: Extended read FOwner_id write FOwner_id;
    property Thumb: TVkAlbumThumb read FThumb write FThumb;
    property Title: string read FTitle write FTitle;
    constructor Create;
    destructor Destroy; override;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TVkAudioAlbum;
  end;

  TVkAudioAds = class
  private
    FAccount_age_type: string;
    FContent_id: string;
    FDuration: string;
    FPuid22: string;
  public
    property AccountAgeType: string read FAccount_age_type write FAccount_age_type;
    property ContentId: string read FContent_id write FContent_id;
    property Duration: string read FDuration write FDuration;
    property PUID22: string read FPuid22 write FPuid22;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TVkAudioAds;
  end;

  TVkAudioChartInfo = class
  private
    FPosition: Integer;
  public
    property Position: Integer read FPosition write FPosition;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TVkAudioChartInfo;
  end;

  TVkAudio = class
  private
    FAccess_key: string;
    FAds: TVkAudioAds;
    FAlbum: TVkAudioAlbum;
    FArtist: string;
    FDate: Extended;
    FDuration: Extended;
    FGenre_id: Integer;
    FId: Integer;
    FIs_licensed: Boolean;
    FMain_artists: TArray<TVkAudioArtist>;
    FOwner_id: Integer;
    FTitle: string;
    FTrack_code: string;
    FUrl: string;
    FLyrics_id: Integer;
    FAlbum_id: Integer;
    FNo_search: Integer;
    FIs_hq: Integer;
    FContent_restricted: Integer;
    FAudio_chart_info: TVkAudioChartInfo;
    FIs_explicit: Boolean;
    function GetAudioGenre: TAudioGenre;
    procedure SetAudioGenre(const Value: TAudioGenre);
  public
    property Id: Integer read FId write FId;
    property OwnerId: Integer read FOwner_id write FOwner_id;
    property Artist: string read FArtist write FArtist;
    property Title: string read FTitle write FTitle;
    property Duration: Extended read FDuration write FDuration;
    property Url: string read FUrl write FUrl;
    property LyricsId: Integer read FLyrics_id write FLyrics_id;
    property AlbumId: Integer read FAlbum_id write FAlbum_id;
    property GenreId: Integer read FGenre_id write FGenre_id;
    property Date: Extended read FDate write FDate;
    property NoSearch: Integer read FNo_search write FNo_search;
    property IsHQ: Integer read FIs_hq write FIs_hq;
    //
    property AccessKey: string read FAccess_key write FAccess_key;
    property Ads: TVkAudioAds read FAds write FAds;
    property IsLicensed: Boolean read FIs_licensed write FIs_licensed;
    property TrackCode: string read FTrack_code write FTrack_code;
    property Album: TVkAudioAlbum read FAlbum write FAlbum;
    property MainArtists: TArray<TVkAudioArtist> read FMain_artists write FMain_artists;
    property ContentRestricted: Integer read FContent_restricted write FContent_restricted;
    property AudioChartInfo: TVkAudioChartInfo read FAudio_chart_info write FAudio_chart_info;
    property IsExplicit: Boolean read FIs_explicit write FIs_explicit;

    //
    property Genre: TAudioGenre read GetAudioGenre write SetAudioGenre;
    constructor Create;
    destructor Destroy; override;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TVkAudio;
    class function FromJsonObject(AJsonObject: TJSONObject): TVkAudio;
  end;

  TVkAudioIndex = record
    OwnerId: Integer;
    AudioId: Integer;
  end;

  TVkAudioIndexes = TArray<TVkAudioIndex>;

  TVkAudios = class
  private
    FItems: TArray<TVkAudio>;
    FCount: Integer;
    FSaveObjects: Boolean;
    procedure SetSaveObjects(const Value: Boolean);
  public
    property Items: TArray<TVkAudio> read FItems write FItems;
    property Count: Integer read FCount write FCount;
    property SaveObjects: Boolean read FSaveObjects write SetSaveObjects;
    procedure Append(Audios: TVkAudios);
    constructor Create;
    destructor Destroy; override;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TVkAudios;
  end;

implementation

{TVkAudioAds}

function TVkAudioAds.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TVkAudioAds.FromJsonString(AJsonString: string): TVkAudioAds;
begin
  result := TJson.JsonToObject<TVkAudioAds>(AJsonString)
end;

{TVkAudio}

constructor TVkAudio.Create;
begin
  inherited;
end;

destructor TVkAudio.Destroy;
var
  Artist: TVkAudioArtist;
begin
  for Artist in FMain_artists do
    Artist.Free;
  if Assigned(FAudio_chart_info) then
    FAudio_chart_info.Free;
  if Assigned(FAlbum) then
    FAlbum.Free;
  if Assigned(FAds) then
    FAds.Free;
  inherited;
end;

function TVkAudio.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TVkAudio.FromJsonObject(AJsonObject: TJSONObject): TVkAudio;
begin
  Result := TJson.JsonToObject<TVkAudio>(AJsonObject);
end;

class function TVkAudio.FromJsonString(AJsonString: string): TVkAudio;
begin
  result := TJson.JsonToObject<TVkAudio>(AJsonString)
end;

function TVkAudio.GetAudioGenre: TAudioGenre;
begin
  Result := AudioGenre.Create(FGenre_Id);
end;

procedure TVkAudio.SetAudioGenre(const Value: TAudioGenre);
begin
  FGenre_id := VkAudioGenres[Value];
end;

{TMain_artistsClass}

function TVkAudioArtist.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TVkAudioArtist.FromJsonString(AJsonString: string): TVkAudioArtist;
begin
  result := TJson.JsonToObject<TVkAudioArtist>(AJsonString)
end;

{TThumbClass}

function TVkAlbumThumb.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TVkAlbumThumb.FromJsonString(AJsonString: string): TVkAlbumThumb;
begin
  result := TJson.JsonToObject<TVkAlbumThumb>(AJsonString)
end;

{TAlbumClass}

constructor TVkAudioAlbum.Create;
begin
  inherited;
  FThumb := TVkAlbumThumb.Create();
end;

destructor TVkAudioAlbum.Destroy;
begin
  FThumb.Free;
  inherited;
end;

function TVkAudioAlbum.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TVkAudioAlbum.FromJsonString(AJsonString: string): TVkAudioAlbum;
begin
  result := TJson.JsonToObject<TVkAudioAlbum>(AJsonString)
end;

{ TVkAudiosHelper }
      {
function TVkAudiosHelper.ToAudioIndexes: TVkAudioIndexes;
var
  i: Integer;
begin
  SetLength(Result, Length(Self));
  for i := Low(Self) to High(Self) do
    Result[i] := [Self[i].OwnerId, Self[i].Id];
end;  }

{ TVkAudios }

procedure TVkAudios.Append(Audios: TVkAudios);
var
  OldLen: Integer;
begin
  OldLen := Length(Items);
  SetLength(FItems, OldLen + Length(Audios.Items));
  Move(Audios.Items[0], FItems[OldLen], Length(Audios.Items) * SizeOf(TVkAudio));
end;

constructor TVkAudios.Create;
begin
  inherited;
  FSaveObjects := False;
end;

destructor TVkAudios.Destroy;
var
  LItemsItem: TVkAudio;
begin
  if not FSaveObjects then
  begin
    for LItemsItem in FItems do
      LItemsItem.Free;
  end;

  inherited;
end;

class function TVkAudios.FromJsonString(AJsonString: string): TVkAudios;
begin
  result := TJson.JsonToObject<TVkAudios>(AJsonString);
end;

procedure TVkAudios.SetSaveObjects(const Value: Boolean);
begin
  FSaveObjects := Value;
end;

function TVkAudios.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

{ TVkAudioChartInfo }

class function TVkAudioChartInfo.FromJsonString(AJsonString: string): TVkAudioChartInfo;
begin
  result := TJson.JsonToObject<TVkAudioChartInfo>(AJsonString);
end;

function TVkAudioChartInfo.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

end.

