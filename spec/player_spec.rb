require 'spec_helper'
require 'player'

describe Player do
  context '#initialize' do
    it 'starts with a name and a sign' do
      player = Player.new({name: "Abel", sign: "Z"})
      expect(player.name).to eq "Abel"
      expect(player.sign).to eq "Z"
    end

    it 'defaults the name to "Anon" if no name is provided' do
      player = Player.new({name: "", sign: "X"})
      expect(player.name).to eq "Anon"
    end

    it 'raises an error if no sign is provided' do
      expect { Player.new({name: "Abel", sign: ""}) }.to raise_error 'You must provide a single-character sign'
    end

    it 'raises an error if sign is longer than 1 character' do
      expect { Player.new({name: "Abel", sign: "XY"}) }.to raise_error 'Your sign should be just 1 character long'
    end
  end
end
