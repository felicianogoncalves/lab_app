FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build
WORKDIR /src
COPY LabApp/LabApp.csproj ./
RUN dotnet restore
COPY LabApp/ ./
RUN dotnet publish -c Release -o /app/publish

FROM mcr.microsoft.com/dotnet/aspnet:10.0
WORKDIR /app
COPY --from=build /app/publish .
USER $APP_UID
ENTRYPOINT ["dotnet", "LabApp.dll"]
