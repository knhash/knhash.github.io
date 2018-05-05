Feature: Validate theme package
  As a hacker who likes to share Nielsen Ramon's expertise
  I want to be able to share this awesome 'jekyll-theme-chalk' gemified theme

  Scenario: Validate output folders structure with "scrollappear" disabled
    Given I have "_config.yml" configuration file with "theme" set to "jekyll-theme-chalk"
    Given I have "features/scrollappear-off.yml" configuration file with "scrollappear_enabled" set to "false"

    When I run jekyll clean
    Then I should get a zero exit status

    When I run jekyll build --config _config.yml,features/scrollappear-off.yml
    Then I should get a zero exit status

    And the _site directory should exist

    And the _site/assets directory should exist

    And the _site/assets/documentation directory should exist

    And the _site/assets/ionicons directory should exist

    And the "_site/assets/scrollappear.js" file should not exist