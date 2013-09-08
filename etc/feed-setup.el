;;; feed-setup.el --- customize my web feeds

(require 'elfeed)
(require 'youtube-dl-mode)

;; youtube-dl config

(setq youtube-dl-directory "/media/wellons")

(defun elfeed-show-youtube-dl ()
  "Download the current entry with youtube-dl."
  (interactive)
  (pop-to-buffer (youtube-dl-download (elfeed-entry-link elfeed-show-entry))))

(defun elfeed-search-youtube-dl ()
  "Download the current entry with youtube-dl."
  (interactive)
  (let ((entries (elfeed-search-selected)))
    (dolist (entry entries)
      (if (null (youtube-dl-download (elfeed-entry-link entry)))
          (message "Entry is not a YouTube link!")
        (message "Downloading %s" (elfeed-entry-title entry)))
      (elfeed-untag entry 'unread)
      (elfeed-search-update-entry entry)
      (unless (use-region-p) (forward-line)))))

(define-key elfeed-show-mode-map "d" 'elfeed-show-youtube-dl)
(define-key elfeed-search-mode-map "d" 'elfeed-search-youtube-dl)

;; Special filters

(add-hook 'elfeed-new-entry-hook
          (elfeed-make-tagger :before "5 days ago"
                              :remove 'unread))

(add-hook 'elfeed-new-entry-hook
          (elfeed-make-tagger :feed-url "HuskyStarcraft"
                              :entry-title '(not "bronze league")
                              :add 'junk
                              :remove 'unread))

(add-hook 'elfeed-new-entry-hook
          (elfeed-make-tagger :feed-url "github\\.com"
                              :entry-title "\\(drinkup\\|githubber\\)"
                              :add 'junk
                              :remove 'unread))

;; The actual feeds listing

(setq elfeed-feeds-alist
      '(("http://threesixty360.wordpress.com/feed/" blog math)
        ("http://www.50ply.com/atom.xml" blog dev)
        ("http://abstrusegoose.com/feed.xml" comic)
        ("http://curiousprogrammer.wordpress.com/feed/" blog dev)
        ("http://feeds.feedburner.com/amazingsuperpowers" comic)
        ("http://amitp.blogspot.com/feeds/posts/default" blog dev)
        ("http://theatticlight.net/atom.xml" blog)
        ("http://pages.cs.wisc.edu/~psilord/blog/rssfeed.rss" blog)
        ("http://www.anticscomic.com/?feed=rss2" comic)
        ("http://feeds.feedburner.com/blogspot/TPQSS" blog dev)
        ("http://www.rsspect.com/rss/asw.xml" comic)
        ("http://beardfluff.com/feed/" comic)
        ("http://bit-player.org/feed" blog math)
        ("http://feeds.feedburner.com/bitquabit" blog dev)
        ("http://simblob.blogspot.com/feeds/posts/default" blog dev)
        ("http://blogofholding.com/?feed=rss2" blog gaming)
        ("http://demonastery.org/rss.php" blog gaming)
        ("http://feeds.feedburner.com/Buttersafe" comic)
        ("http://feeds.feedburner.com/CatVersusHuman" comic)
        ("http://chainsawsuit.com/feed/" comic)
        ("http://feeds.feedburner.com/channelATE" comic)
        ("http://www.cheeseburgersinthesky.com/feed/" comic)
        ("http://feeds.feedburner.com/codeincomplete" blog dev)
        ("http://lisptips.com/rss" blog dev lisp)
        ("http://completelyseriouscomics.com/?feed=rss2" comic)
        ("http://cowbirdsinlove.com/feed/" comic)
        ("http://feeds.feedburner.com/DamnCoolPics" image)
        ("http://echosa.github.io/atom.xml" blog dev)
        ("http://www.devrand.org/feeds/posts/default" blog dev)
        ("http://random.terminally-incoherent.com/rss" image)
        ("http://divisbyzero.com/feed/" blog math)
        ("http://dorophone.blogspot.com/feeds/posts/default" blog dev)
        ("http://www.drawuntilitsfunny.com/feed/" comic)
        ("http://crawl.develz.org/wordpress/feed" blog gaming)
        ("http://dvdp.tumblr.com/rss" image)
        ("http://bay12games.com/dwarves/dev_now.rss" blog gaming)
        ("http://www.soa-world.de/echelon/feed" blog dev)
        ("http://emacs-fu.blogspot.com/feeds/posts/default" blog dev emacs)
        ("http://www.ericsink.com/rss.xml" blog dev)
        ("http://feeds.feedburner.com/Explosm" comic)
        ("http://www.extrafabulouscomics.com/1/feed" comic)
        ("http://exocomics.com/feed" comic)
        ("http://feeds.feedburner.com/Pidjin" comic)
        ("http://inkwellideas.com/feed/" blog gaming)
        ("http://feeds.feedburner.com/InvisibleBread" comic)
        ("http://blog.ioactive.com/feeds/posts/default" blog security)
        ("http://irreal.org/blog/?feed=rss2" blog emacs)
        ("http://feeds.feedburner.com/JoelKirchartz" blog)
        ("http://jorgetavares.com/feed/" blog dev)
        ("http://www.leadpaintcomics.com/feed/" comic)
        ("http://feeds.feedburner.com/lefthandedtoons/awesome" comic)
        ("http://gottwurfelt.wordpress.com/feed/" blog math)
        ("http://loldwell.com/?feed=rss2" comic)
        ("http://www.malloc47.com/rss.xml" blog dev)
        ("http://maneggs.com/feed/" comic)
        ("http://www.masteringemacs.org/feed/" blog emacs)
        ("http://www.ma3comic.com/comic.rss" comic)
        ("http://www.mercworks.net/feed/" comic)
        ("http://feeds.feedburner.com/MimiAndEunice" comic)
        ("http://mrdiv.tumblr.com/rss" image)
        ("http://www.mrlovenstein.com/rss.xml" comic)
        ("http://mycardboardlife.com/feed" comic)
        ("http://nedroid.com/feed/" comic)
        ("http://nklein.com/feed/" blog dev)
        ("http://www.npccomic.com/feed/" comic)
        ("http://nullprogram.com/feed/" blog dev)
        ("http://www.optipess.com/feed/" comic)
        ("http://pandyland.net/feed/" comic)
        ("http://www.rsspect.com/rss/pfsc.xml" comic)
        ("http://possiblywrong.wordpress.com/feed/" blog math puzzle)
        ("http://problemtown.com/feed/" comic)
        ("http://feeds.wnyc.org/radiolab" audio)
        ("http://raganwald.com/atom.xml" blog dev)
        ("http://research.swtch.com/feed.atom" blog security)
        ("http://richardwiseman.wordpress.com/feed/" blog puzzle)
        ("http://stochastix.wordpress.com/feed/" blog math)
        ("http://feeds.feedburner.com/rolang" blog gaming)
        ("http://www.safelyendangered.com/feed/" comic)
        ("http://www.schneier.com/blog/atom.xml" blog security)
        ("http://sea-of-memes.com/rss.xml" blog dev)
        ("http://seemikedraw.com.au/feed" comic)
        ("http://www.skullsecurity.org/blog/feed" blog security)
        ("http://www.smbc-comics.com/rss.php" comic)
        ("http://sorrycomics.blogspot.com/feeds/posts/default" comic)
        ("http://feeds.feedburner.com/spaceavalanche1" comic)
        ("http://stevelosh.com/feed/" blog dev)
        ("http://storyboardcomics.blogspot.com/feeds/posts/default" comic)
        ("http://www.terminally-incoherent.com/blog/feed/" blog)
        ("http://bradcolbow.com/feed/" comic)
        ("http://thecodelesscode.com/rss" dev story)
        ("https://github.com/blog.atom" blog dev)
        ("http://feeds.feedburner.com/thetechnium" blog)
        ("http://blog.plover.com/index.atom" blog dev)
        ("http://notch.tumblr.com/rss" blog gaming)
        ("http://batsov.com/atom.xml" blog emacs)
        ("http://towerdive.com/feed/" blog)
        ("http://www.shamusyoung.com/twentysidedtale/?feed=rss2" blog gaming)
        ("http://blog.vivekhaldar.com/rss" blog)
        ("http://what-if.xkcd.com/feed.atom" blog)
        ("http://whattheemacsd.com/atom.xml" emacs)
        ("http://www.whompcomic.com/feed/" comic)
        ("http://blag.xkcd.com/feed/" blog)
        ("http://xkcd.com/atom.xml" comic)
        ("emacs.announce" gmane emacs)
        ("Base14Productions" youtube)
        ("BattleBunny1979" youtube)
        ("BlueXephos" youtube)
        ("Briarstoned" youtube)
        ("Campster" youtube)
        ("DonkeyPuncher1976" youtube)
        ("GetDaved" youtube)
        ("GhazPlays" youtube)
        ("HuntrBlackLuna" youtube)
        ("HuskyStarcraft" youtube)
        ("JonTronShow" youtube)
        ("MatthiasWandel" youtube)
        ("Mestherion" youtube)
        ("MrUnderlay" youtube)
        ("PlumpHelmetPunk" youtube)
        ("Scruit" youtube)
        ("Vihart" youtube)
        ("ZombieOrpheusEnt" youtube)
        ("ZoochosisCom" youtube)
        ("davidr64yt" youtube)
        ("eEconomics" youtube)
        ("emacsrocks" youtube)
        ("engineerguyvideo" youtube)
        ("friendznet" youtube)
        ("jefmajor" youtube)
        ("kmgpsu" youtube)
        ("phreakindee" youtube)
        ("praxgirl" youtube)
        ("quill18" youtube)
        ("skiptherules" youtube)
        ("zzandr1o" youtube)
        ("PLibNZv5Zd0dwAkwoZtRHfn3tPsdOy-VuF" codefellas playlist)))

(defvar elfeed-tagger-db (make-hash-table :test 'equal)
  "Marks what feeds get what tags.")

(setq elfeed-feeds
      (loop with youtube =
            "http://gdata.youtube.com/feeds/base/users/%s/uploads"
            with playlist =
            "https://gdata.youtube.com/feeds/api/playlists/%s"
            with gmane =
            "http://rss.gmane.org/topics/complete/gmane.%s"
            for (url . tags) in elfeed-feeds-alist
            for real-url = (cond
                            ((member 'youtube tags) (format youtube url))
                            ((member 'playlist tags) (format playlist url))
                            ((member 'gmane tags) (format gmane url))
                            (:otherwise url))
            do (setf (gethash real-url elfeed-tagger-db) tags)
            collect real-url))

(defun elfeed-tagger-db-tagger (entry)
  "Tag ENTRY using the `elfeed-tagger-db'."
  (let* ((feed-url (elfeed-feed-url (elfeed-entry-feed entry)))
         (tags (gethash feed-url elfeed-tagger-db)))
    (apply #'elfeed-tag entry tags)))

(add-hook 'elfeed-new-entry-hook 'elfeed-tagger-db-tagger)

(provide 'feed-setup)

;;; feed-setup.el ends here
