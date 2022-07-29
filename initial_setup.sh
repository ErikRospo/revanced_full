let TOKEN="ghp_token"
let USER="ghp_user"
mkdir ~/.gradle
mkdir ~/revanced
cat "gpr.user=$USER\ngpr.token=$TOKEN" > ~/gradle/gradle.properties
echo "Gradle properties file created"
echo "Upgrading Packages"
yes|sudo apt upgrade
echo "Updating Packages"
yes|sudo apt update
echo "Installing Gradle"
yes|sudo apt-get install gradle
echo "Gradle installed"
cd  ~/revanced


echo "Downloading Revanced Patcher"
git clone https://github.com/revanced/revanced-patcher && cd revanced-patcher 
echo "Revanced Patcher downloaded"

echo "Building Revanced Patcher"
./gradlew build && cd ..
echo "Revanced Patcher built"


echo "Downloading Revanced Patches"
git clone https://github.com/revanced/revanced-patches && cd revanced-patches
echo "Revanced Patches downloaded"

echo "Building Revanced Patches"
./gradlew build && cd ..
echo "Revanced Patches built"


echo "Downloading Revanced Integrations"
git clone https://github.com/revanced/revanced-integrations && cd revanced-integrations
echo "Revanced Integrations downloaded"

echo "Building Revanced Integrations"
./gradlew build && cd ..
echo "Revanced Integrations built"


echo "Downloading Revanced CLI"
git clone https://github.com/revanced/revanced-cli && cd revanced-cli
echo "Revanced CLI downloaded"

echo "Building Revanced CLI"
./gradlew build && cd ..
echo "Revanced CLI built"

echo "Initial setup complete"

#ask the user if they want to install the app
echo "Do you want to install the app?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) echo "Installing the app"; break;;
        No ) echo "Not installing the app"; exit;;
    esac
done
# ask the user where the apk is located
echo "Where is the apk located?"
read apk_location
echo "The apk is located at $apk_location"
echo "What is the device's IP address?"
read device_ip
echo "The device's IP address is $device_ip"
echo "What is the device's port?"
read device_port
echo "The device's port is $device_port"
echo "JRE cli arguments? (optional)"
read jre_cli_args
echo "JRE cli arguments are $jre_cli_args"
java -jar revanced-cli/build/libs/revanced-cli-2.7.1-all.jar -a $apk_location -c -d $device_ip:$device_port -o revanced-integrations/app/build/outputs/apk/release/app-release-unsigned.apk -b revanced-patches/build/libs/revanced-patches-2.25.3.jar -m revanced-integrations/app/build/outputs/apk/release/app-release-unsigned.apk $jre_cli_args
#echo "Please run the following command to run the app:"
