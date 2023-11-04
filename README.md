# knhash.github.io
Personal blog

# Steps to set up develop environment 

### Clone the repository  
`git clone https://github.com/knhash/knhash.github.io.git`

### Install all pre-requisites  
https://jekyllrb.com/docs/installation/  

#### > Under Ubuntu Linux:
https://jekyllrb.com/docs/installation/ubuntu/  
```
sudo apt update
sudo apt upgrade
sudo apt-get install ruby-full build-essential zlib1g-dev
echo '# Install Ruby Gems to ~/gems' >> ~/.bashrc
echo 'export GEM_HOME="$HOME/gems"' >> ~/.bashrc
echo 'export PATH="$HOME/gems/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
gem install jekyll bundler
```

### Install all necessary gems
```
cd knhash.github.io
bundle install
```

### Run development server
Uncomment the following line in `_config.yml`:  
`theme: jekyll-bear-theme`  
and comment the line after it:  
`remote_theme: knhash/jekyllBear`  

> Remember to revert these changes before going to prod

```
bundle exec jekyll serve --livereload
```