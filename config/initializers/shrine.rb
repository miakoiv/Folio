require 'shrine'
require 'shrine/storage/file_system'

Shrine.storages = {
  cache: Shrine::Storage::FileSystem.new('public', prefix: 'uploads/cache'), # temporary
  store: Shrine::Storage::FileSystem.new('public', prefix: 'uploads/store'), # permanent
}

Shrine.plugin :activerecord
Shrine.plugin :logging
Shrine.plugin :determine_mime_type
