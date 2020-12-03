## Web环境ImageIO报错
source: `{{ page.path }}`

	ImageIO在Web环境报: java.lang.NoClassDefFoundError: com/github/jaiimageio/stream/RawImageInputStream
	这是因为ImageIO注册在JVM global, 而不支持Web Context. 需要在上下文中注册
	注册完成后, 需要重启(ImageIO运行环境被污染了)

	见[haraldk/TwelveMonkeys](https://github.com/haraldk/TwelveMonkeys#deploying-the-plugins-in-a-web-app)

	<dependencies>
        ...
        <dependency>
            <groupId>com.twelvemonkeys.imageio</groupId>
            <artifactId>imageio-jpeg</artifactId>
            <version>3.4.2</version>
        </dependency>
        <dependency>
            <groupId>com.twelvemonkeys.imageio</groupId>
            <artifactId>imageio-tiff</artifactId>
            <version>3.4.2</version>
        </dependency>

        <!--
        Optional dependency. Needed only if you deploy `ImageIO` plugins as part of a web app.
        Make sure you add the `IIOProviderContextListener` to your `web.xml`, see above.
        -->
        <dependency>
            <groupId>com.twelvemonkeys.servlet</groupId>
            <artifactId>servlet</artifactId>
            <version>3.4.2</version>
        </dependency>
    </dependencies>

在web.xml中配置

	 <web-app ...>

    ...

        <listener>
            <display-name>ImageIO service provider loader/unloader</display-name>
            <listener-class>com.twelvemonkeys.servlet.image.IIOProviderContextListener</listener-class>
        </listener>

    ...

    </web-app>
