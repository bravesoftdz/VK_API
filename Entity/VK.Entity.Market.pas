unit VK.Entity.Market;

interface

uses
  Generics.Collections, Rest.Json;

type
  TVkMarketCurrency = class
  private
    FId: Extended;
    FName: string;
  public
    property Id: Extended read FId write FId;
    property Name: string read FName write FName;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TVkMarketCurrency;
  end;

  TVkMarketPrice = class
  private
    FAmount: string;
    FCurrency: TVkMarketCurrency;
    FText: string;
  public
    property Amount: string read FAmount write FAmount;
    property Currency: TVkMarketCurrency read FCurrency write FCurrency;
    property Text: string read FText write FText;
    constructor Create;
    destructor Destroy; override;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TVkMarketPrice;
  end;

  TVkMarketSection = class
  private
    FId: Extended;
    FName: string;
  public
    property Id: Extended read FId write FId;
    property Name: string read FName write FName;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TVkMarketSection;
  end;

  TVkMarketCategory = class
  private
    FId: Extended;
    FName: string;
    FSection: TVkMarketSection;
  public
    property Id: Extended read FId write FId;
    property Name: string read FName write FName;
    property Section: TVkMarketSection read FSection write FSection;
    constructor Create;
    destructor Destroy; override;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TVkMarketCategory;
  end;

  TVkMarket = class
  private
    FAvailability: Extended;
    FCategory: TVkMarketCategory;
    FDate: Extended;
    FDescription: string;
    FExternal_id: string;
    FId: Extended;
    FOwner_id: Extended;
    FPrice: TVkMarketPrice;
    FThumb_photo: string;
    FTitle: string;
  public
    property Availability: Extended read FAvailability write FAvailability;
    property Category: TVkMarketCategory read FCategory write FCategory;
    property Date: Extended read FDate write FDate;
    property Description: string read FDescription write FDescription;
    property ExternalId: string read FExternal_id write FExternal_id;
    property Id: Extended read FId write FId;
    property OwnerId: Extended read FOwner_id write FOwner_id;
    property Price: TVkMarketPrice read FPrice write FPrice;
    property ThumbPhoto: string read FThumb_photo write FThumb_photo;
    property Title: string read FTitle write FTitle;
    constructor Create;
    destructor Destroy; override;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TVkMarket;
  end;

  TVkMarketAlbum = class
  private
    FAvailability: Extended;
    FCategory: TVkMarketCategory;
    FDate: Extended;
    FDescription: string;
    FExternal_id: string;
    FId: Extended;
    FOwner_id: Extended;
    FPrice: TVkMarketPrice;
    FThumb_photo: string;
    FTitle: string;
  public
    property Availability: Extended read FAvailability write FAvailability;
    property Category: TVkMarketCategory read FCategory write FCategory;
    property Date: Extended read FDate write FDate;
    property Description: string read FDescription write FDescription;
    property ExternalId: string read FExternal_id write FExternal_id;
    property Id: Extended read FId write FId;
    property OwnerId: Extended read FOwner_id write FOwner_id;
    property Price: TVkMarketPrice read FPrice write FPrice;
    property ThumbPhoto: string read FThumb_photo write FThumb_photo;
    property Title: string read FTitle write FTitle;
    constructor Create;
    destructor Destroy; override;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TVkMarketAlbum;
  end;

implementation

{TVkMarketCurrency}

function TVkMarketCurrency.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TVkMarketCurrency.FromJsonString(AJsonString: string): TVkMarketCurrency;
begin
  result := TJson.JsonToObject<TVkMarketCurrency>(AJsonString)
end;

{TVkMarketPrice}

constructor TVkMarketPrice.Create;
begin
  inherited;
  FCurrency := TVkMarketCurrency.Create();
end;

destructor TVkMarketPrice.Destroy;
begin
  FCurrency.Free;
  inherited;
end;

function TVkMarketPrice.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TVkMarketPrice.FromJsonString(AJsonString: string): TVkMarketPrice;
begin
  result := TJson.JsonToObject<TVkMarketPrice>(AJsonString)
end;

{TVkMarketSection}

function TVkMarketSection.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TVkMarketSection.FromJsonString(AJsonString: string): TVkMarketSection;
begin
  result := TJson.JsonToObject<TVkMarketSection>(AJsonString)
end;

{TVkMarketCategory}

constructor TVkMarketCategory.Create;
begin
  inherited;
  FSection := TVkMarketSection.Create();
end;

destructor TVkMarketCategory.Destroy;
begin
  FSection.Free;
  inherited;
end;

function TVkMarketCategory.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TVkMarketCategory.FromJsonString(AJsonString: string): TVkMarketCategory;
begin
  result := TJson.JsonToObject<TVkMarketCategory>(AJsonString)
end;

{TVkMarket}

constructor TVkMarket.Create;
begin
  inherited;
  FCategory := TVkMarketCategory.Create();
  FPrice := TVkMarketPrice.Create();
end;

destructor TVkMarket.Destroy;
begin
  FCategory.Free;
  FPrice.Free;
  inherited;
end;

function TVkMarket.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TVkMarket.FromJsonString(AJsonString: string): TVkMarket;
begin
  result := TJson.JsonToObject<TVkMarket>(AJsonString)
end;

{TVkMarketAlbum}

constructor TVkMarketAlbum.Create;
begin
  inherited;
  FCategory := TVkMarketCategory.Create();
  FPrice := TVkMarketPrice.Create();
end;

destructor TVkMarketAlbum.Destroy;
begin
  FCategory.Free;
  FPrice.Free;
  inherited;
end;

function TVkMarketAlbum.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TVkMarketAlbum.FromJsonString(AJsonString: string): TVkMarketAlbum;
begin
  result := TJson.JsonToObject<TVkMarketAlbum>(AJsonString)
end;

end.

