module TownCrier::Config
  TownCrier::Config::Jabber = File.exist?(File.join(TownCrier::Engine.root,'config','jabber.yml')) ?
    YAML.load(File.read(File.join(TownCrier::Engine.root,'config','jabber.yml'))) :
    nil
end
