#!/bin/bash
set -e

echo "Overriding nuget configuration in /home/ide/.nuget/NuGet/NuGet.Config"
cat << EOF > /home/ide/.nuget/NuGet/NuGet.Config
<?xml version="1.0" encoding="utf-8"?>
<configuration>
  <packageSources>
    <add key="liget" value="http://liget:9011/api/v2" protocolVersion="2" />
  </packageSources>
</configuration>
EOF

E2E_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

for test_dir in `find $E2E_DIR -mindepth 1 -type d -name 'test_*'`
do
    echo "Running tests in $test_dir"
    cd $test_dir && bats .
done
