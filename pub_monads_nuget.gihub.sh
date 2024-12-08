#!/bin/bash

# Load .env variables
if [ -f .env ]; then
  export $(grep -v '^#' .env | xargs)
fi

dotnet build --configuration Release

rm -r ./nupkg/monads.*
dotnet pack --no-build ./src/monads.csproj -o ./nupkg

dotnet nuget push ./nupkg/monads.*.nupkg \
    --api-key $GITHUB_ACCESS_TOKEN \
    --source https://nuget.pkg.github.com/sandhaka/index.json \
    --skip-duplicate
