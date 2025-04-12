FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /App
EXPOSE 80

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY ["CodeCraftDemo.csproj", "./"]
RUN dotnet restore "CodeCraftDemo.csproj"
COPY . .
RUN dotnet publish "CodeCraftDemo.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "CodeCraftDemo.dll"]
