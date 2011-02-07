# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.
#PRATIK PRAMANIK IS GOING TO EAT YOUR BRAINS!!!!!!!!!!!! 2/6/2011
#in lib/tasks/
directory "videos"

task :default do
  puts "Possible Cmds:"
  puts "   vid_import"
  puts "   sync_db"
end

task :vid_import => "videos" do
  puts "Importing Videos."
  #Chris's code goes here if necessary
    #<alt> Chris's code leaves a flag saying new videos have been imported, prevents this task from running unless new shit is added. something like that. we'll see.
end


task :sync_db => :environment do
  puts "Synchronizing DB."

  #1. Grabs DB (intervals [note: dedi video db later])
  puts "DB->files"
  #table = database searching cmd(:intervals)
  #2. Checks <interval> elements for unstandardized video filepaths (videos not in /videos/<ID>/)
  Interval.all.each do | itvl |
    #3. for Non-conforming elements: Move/Copy files at original filepath to the standardized filepaths (file rename not necessary)
    if itvl.filename != "videos/"+itvl.id.to_s+"/*"
      filenm = File.basename(itvl.filename)
      mv itvl.filename "../../videos/"+itvl.id.to_s+"/"+filenm
      #4. Update DB to reflect new file structure
      itvl.filename = "videos/"+itvl.id.to_s+"/"+filenm
    end
  end
  #5. Check video folder for videos without a listing in the database
  puts "files->DB"
  files = Dir.glob("*.*") #only files with extensions (aka no folders, script files)
  files.all.each do | file |
    #6. Create a new listing in DB
    #table.new(:interval with some DUMMY information that signals its an "Uncategorized" movie)
    newfile = Interval.new
    newfile.save
    #7. videos should be placed in a folder-bucket(name: db ID) if not in a folder already
    newfile.filename = "videos/"+newfile.id.to_s+"/"+File.basename(file)
    mv file newfile.filename
    newfile.save
  end
end

=begin
#just a test method, delete later
task :make_vid => "videos" do
  sh "echo 'Video' >> 'videos/test.tmp'"
  mv "videos/test.tmp","videos/test_move.tp"
  files = Dir.glob("*.*")
  files.each do | file |

  end
end
=end

