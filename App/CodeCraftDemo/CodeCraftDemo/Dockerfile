# Stage 1: Base image for runtime
FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 80

# Stage 2: Build
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src

# Copy only the .csproj first for caching
COPY CodeCraftDemo.csproj ./
RUN dotnet restore "CodeCraftDemo.csproj"

# Copy rest of the source code
COPY . .

# Build and publish
RUN dotnet publish "CodeCraftDemo.csproj" -c Release -o /app/publish

# Stage 3: Final image
FROM base AS final
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "CodeCraftDemo.dll"]
