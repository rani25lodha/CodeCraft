# Stage 1: Base image for runtime
FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 80

# Stage 2: Build
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src

COPY CodeCraftDemo.csproj ./
RUN dotnet restore "CodeCraftDemo.csproj"

COPY . .

RUN dotnet publish "CodeCraftDemo.csproj" -c Release -o /app/publish

# Stage 3: Final image
FROM base AS final
WORKDIR /app
COPY ./out .        # ⬅️ Make sure this matches the actual published folder
ENTRYPOINT ["dotnet", "CodeCraftDemo.dll"]
