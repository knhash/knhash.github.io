Feature: Validate theme package
  As a hacker who likes to share Nielsen Ramon's expertise
  I want to be able to share this awesome 'jekyll-theme-chalk' gemified theme

  Scenario: Validate output folders structure with all defaults
    Given I have a configuration file with "theme" set to "jekyll-theme-chalk"
    Given I have a configuration file with "about_enabled" set to "false"
    Given I have a configuration file with "local_fonts" set to "false"
    Given I have a configuration file with "rss_enabled" set to "true"
    Given I have a configuration file with "scrollappear_enabled" set to "true"

    When I run jekyll clean
    Then I should get a zero exit status

    When I run jekyll build
    Then I should get a zero exit status

    And the _site directory should exist

    And the _site/assets directory should exist
    And the "_site/assets/about.jpg" file should exist
    And the "_site/assets/apple-touch-icon.png" file should exist
    And the "_site/assets/application.js" file should exist

    And the _site/assets/documentation directory should exist
    And the "_site/assets/documentation/chalk-intro.png" file should exist
    And the "_site/assets/documentation/chalk-intro@2x.png" file should exist
    And the "_site/assets/documentation/enlarge.gif" file should exist
    And the "_site/assets/documentation/enlarge@2x.gif" file should exist
    And the "_site/assets/documentation/sample-image.jpg" file should exist
    And the "_site/assets/documentation/sample-image@2x.jpg" file should exist

    And the _site/assets/ionicons directory should exist
    And the "_site/assets/ionicons/ionicons.eot" file should exist
    And the "_site/assets/ionicons/ionicons.ttf" file should exist
    And the "_site/assets/ionicons/ionicons.woff" file should exist

    And the "_site/assets/light.css" file should exist
    And the "_site/assets/notfound-light.css" file should exist
    And the "_site/assets/og-image.jpg" file should exist
    And the "_site/assets/scrollappear.js" file should exist
    And the "_site/assets/vendor.js" file should exist
    And the "_site/assets/webfonts.js" file should exist