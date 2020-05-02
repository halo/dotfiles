require 'spec_helper'

RSpec.describe Git::Actions::Cut do
  context 'without a git repositoy' do
    before do
      Dir.chdir '/tmp'
    end

    it 'explains what went wrong' do
      expect do
        begin
          described_class.new.call
        rescue SystemExit
        end
      end.to output(/not a git repository/).to_stderr
    end

    it 'aborts' do
      expect do
        described_class.new.call
      end.to raise_error SystemExit
    end
  end

  context 'with a dirty working tree' do
    before :all do
      directory = "/tmp/#{SecureRandom.hex}"
      Dir.mkdir directory
      Dir.chdir directory
      system 'git init > /dev/null'
      system 'git config user.name bob'
      system 'git config user.email bob@example.com'
      system 'touch i-am-dirty.txt'
      system 'git add .'
    end

    it 'explains what went wrong' do
      expect do
        begin
          described_class.new.call
        rescue SystemExit
        end
      end.to output(/branch is dirty/).to_stderr
    end

    it 'aborts' do
      expect do
        described_class.new.call
      end.to raise_error SystemExit
    end
  end

  context 'when on a different branch' do
    it 'switches back to that branch' do
      directory = "/tmp/#{SecureRandom.hex}"
      Dir.mkdir directory
      Dir.chdir directory
      system 'git init > /dev/null'
      system 'git config user.name bob'
      system 'git config user.email bob@example.com'
      system 'touch i-am-on-master.txt'
      system 'git add .'
      system 'git commit -m my-master'

      system 'git checkout -b cool-feature'
      system 'touch cool-feature.txt'
      system 'git add .'
      system 'git commit -m cool-feature'

      system 'git checkout -b draft-feature'
      system 'touch draft-feature.txt'
      system 'git add .'
      system 'git commit -m draft-feature'

      system 'git checkout master'
      system 'git merge cool-feature'
      system 'git checkout draft-feature'

      expect do
        begin
          described_class.new.call
        rescue SystemExit
        end
      end.to output(/Deleting branch cool-feature/).to_stdout

      expect(`git symbolic-ref --short HEAD`.chomp).to eq 'draft-feature'
    end

  end
end
