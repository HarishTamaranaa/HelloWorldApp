# Use the official Microsoft .NET 7.0 SDK image to build the application

FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build-env

WORKDIR /app

# Copy the csproj and restore any dependencies (via 'dotnet restore')

COPY *.csproj ./

RUN dotnet restore

# Copy the rest of the application code and build the project

COPY . ./

RUN dotnet publish -c Release -o out

# Use a runtime image for production. This is much smaller than the SDK image.

FROM mcr.microsoft.com/dotnet/aspnet:7.0

WORKDIR /app

COPY --from=build-env /app/out .

# Expose port 8080 (or your application's port)

EXPOSE 8080

# Set the entry point to run the application

ENTRYPOINT ["dotnet", "YourProjectName.dll"]
 