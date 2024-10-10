# Use the official .NET SDK image to build the app

FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build

WORKDIR /app

# Copy the project files and restore any dependencies

COPY *.csproj ./

RUN dotnet restore

# Copy the rest of the application and build it

COPY . ./

RUN dotnet publish -c Release -o out

# Use the official ASP.NET runtime image to run the app

FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS runtime

WORKDIR /app

COPY --from=build /app/out .

# Set the entry point for the container

ENTRYPOINT ["dotnet", "DemoHelloWorld.dll"]
 