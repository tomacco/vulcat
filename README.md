<style>

.frame {
  margin:50px auto;
  border:25px solid #222;
  height:400px;
  width:400px;
  -webkit-box-shadow:  1px 2px 3px 1px rgba(0, 0, 0, .5);
  box-shadow:  0 3px 10px 4px rgba(0, 0, 0, .3);
}

.border {
  background:white;
  height:100%;
  width:100%;
  -webkit-box-shadow: inset 10px 10px 10px 4px rgba(0, 0, 0, .4);
  box-shadow: inset 3px 7px 2px 5px rgba(0, 0, 0, .4);
}

.image {
  position:absolute;
  height:250px;
  width:250px;
  margin-left:50px;
  margin-top:50px;
  -webkit-box-shadow: inset 10px 10px 10px 4px rgba(0, 0, 0, .6);
  box-shadow: inset 3px 7px 2px 5px rgba(0, 0, 0, .1);
  border:2px inset #c9c9c9;
}
</style>

# Vulcat

Your fluffy friend that looks for transitive dependencies.

<div class="frame" style="text-align: center;">
  <div class="border">
    <div class="image">
      <img src="/vulcat.png"width="250" alt="" />
    </div><!--end image-->
  </div><!--end border-->
</div><!--end frame-->

## About

VulCat is script that runs on top of 

`./gradlew dependencyInsight --configuration $config --dependency $dependency`

So it only works on Gradle-based projects.

## Usage

`./vulcat dependency_name`

By default, vulcat will run the `dependencyInsight` on the `testCompileClasspath` and `compileClasspath` configurations.
If you want to run it with ALL your configurations, pass the `--allConfigs`

`./vulcat dependency_name --allConfigs`


e.g

`./vulcat xnio-api`

**Output**

```bash

org.jboss.xnio:xnio-api:3.8.16.Final
\--- io.undertow:undertow-core:2.3.15.Final
     +--- compileClasspath
     +--- org.springframework.boot:spring-boot-starter-undertow:3.2.8 (requested io.undertow:undertow-core:2.3.13.Final)
     |    \--- compileClasspath (requested org.springframework.boot:spring-boot-starter-undertow)
     +--- io.undertow:undertow-websockets-jsr:2.3.15.Final
     |    +--- compileClasspath
     |    \--- org.springframework.boot:spring-boot-starter-undertow:3.2.8 (requested io.undertow:undertow-websockets-jsr:2.3.13.Final) (*)
     \--- io.undertow:undertow-servlet:2.3.15.Final
          +--- compileClasspath
          +--- org.springframework.boot:spring-boot-starter-undertow:3.2.8 (requested io.undertow:undertow-servlet:2.3.13.Final) (*)
          \--- io.undertow:undertow-websockets-jsr:2.3.15.Final (*)
```

This output shows that the _transitive dependency_ `org.jboss.xnio:xnio-api:3.8.16.Final`, is being imported by ` io.undertow:undertow-websockets-jsr:2.3.15.Final`.



