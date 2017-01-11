require 'shrine'
require 'shrine/storage/file_system'

Shrine.storages = {
  cache: Shrine::Storage::FileSystem.new('public',
    prefix: ['uploads', ENV['SHRINE_STORAGE'], 'cache'].join('/')), # temporary
  store: Shrine::Storage::FileSystem.new('public',
    prefix: ['uploads', ENV['SHRINE_STORAGE'], 'store'].join('/')), # permanent
}

Shrine.plugin :activerecord
Shrine.plugin :logging, logger: Rails.logger
Shrine.plugin :pretty_location
Shrine.plugin :determine_mime_type
