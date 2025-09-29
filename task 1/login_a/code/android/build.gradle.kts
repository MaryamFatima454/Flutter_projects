allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir = File(rootDir, "../build")
rootProject.buildDir = newBuildDir

subprojects {
    project.buildDir = File(newBuildDir, project.name)
}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}