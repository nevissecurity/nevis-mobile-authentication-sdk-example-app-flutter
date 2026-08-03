fun getConfig(name: String): String {
    val localPropertiesFile = rootDir.resolve("local.properties")
    if (localPropertiesFile.exists()) {
        val localProperties = java.util.Properties()
        localPropertiesFile.inputStream().use { localProperties.load(it) }
        localProperties.getProperty(name)?.let { return it }
    }
    System.getenv(name)?.let { return it }
    System.getProperty(name)?.let { return it }
    providers.gradleProperty(name).orNull?.let { return it }
    throw GradleException(
        "Getting configuration with name $name failed! Set it as environment variable or as local/project/system property."
    )
}

allprojects {
    repositories {
        google()
        mavenCentral()
        maven {
            url = uri("https://maven.pkg.github.com/nevissecurity/nevis-mobile-authentication-sdk-android-package")
            credentials {
                username = getConfig("GH_USERNAME")
                password = getConfig("GH_PERSONAL_ACCESS_TOKEN")
            }
        }
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)
subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    group = "build"
    description = "Deletes the build directory."
    delete(rootProject.layout.buildDirectory)
}
