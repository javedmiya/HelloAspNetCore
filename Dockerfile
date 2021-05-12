FROM mcr.microsoft.com/dotnet/aspnet:3.1 AS base
WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/sdk:3.1 AS build
WORKDIR /src
COPY ["HelloASPNetCore.csproj", "./"]
RUN dotnet restore "HelloASPNetCore.csproj"
COPY . .
RUN dotnet build "HelloASPNetCore.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "HelloASPNetCore.csproj" -c Release -o /app/publish

FROM base AS final 
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "HelloASPNetCore.dll"]
