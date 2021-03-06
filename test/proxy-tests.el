(require 'ert)
(require 'ert-expectations)
(require 'el-mock)

(expectations (desc "orgtrello-proxy/--dispatch-action")
              (expect 'orgtrello-proxy/--delete      (orgtrello-proxy/--dispatch-action "delete"))
              (expect 'orgtrello-proxy/--sync-entity (orgtrello-proxy/--dispatch-action "sync-entity"))
              (expect nil                            (orgtrello-proxy/--dispatch-action "nothing")))

(expectations (desc "orgtrello-proxy/--compute-pattern-search-from-marker")
              (expect "marker-is-a-trello-id" (orgtrello-proxy/--compute-pattern-search-from-marker "marker-is-a-trello-id"))
              (expect "orgtrello-marker-tony" (orgtrello-proxy/--compute-pattern-search-from-marker "orgtrello-marker-tony")))

(expectations (desc "orgtrello-proxy/--archived-scanning-file")
              (expect "test/folder/.scanning/filename" (orgtrello-proxy/--archived-scanning-file "test/folder/filename")))

(expectations (desc "orgtrello-proxy/--update-buffer-to-save")
              (expect '(:a) (orgtrello-proxy/--update-buffer-to-save :a nil))
              (expect '(:a) (orgtrello-proxy/--update-buffer-to-save :a '(:a)))
              (expect '(:a :b) (orgtrello-proxy/--update-buffer-to-save :a '(:b))))

(expectations (desc "orgtrello-proxy/update-buffer-to-save!")
              (setq *ORGTRELLO-LIST-BUFFERS-TO-SAVE* nil)
              (expect '(:a) (orgtrello-proxy/update-buffer-to-save! :a))
              (expect '(:a) (orgtrello-proxy/update-buffer-to-save! :a))
              (expect '(:b :a) (orgtrello-proxy/update-buffer-to-save! :b)))

(expectations
 (expect t
         (hash-equal #s(hash-table size 65 test equal rehash-size 1.5 rehash-threshold 0.8 data
                                   (:callback "orgtrello-controller/--sync-buffer-with-trello-data-callback" :buffername "todo-TESTS-simple.org" :position nil :params
                                              ((actions . "commentCard")
                                               (field . "closed,desc,due,idBoard,idChecklists,idList,idMembers,name,pos"))
                                              :uri "/boards/51d99bbc1e1d8988390047f2/cards"
                                              :method "GET"
                                              :sync t
                                              :name "some name"
                                              :id "some id"
                                              :action "some action"
                                              :level 3
                                              :start nil))
                     (orgtrello-proxy/parse-query '((callback . "orgtrello-controller/--sync-buffer-with-trello-data-callback")
                                                    (buffername . "todo-TESTS-simple.org")
                                                    (position)
                                                    (params (actions . "commentCard") (field . "closed,desc,due,idBoard,idChecklists,idList,idMembers,name,pos"))
                                                    (uri . "/boards/51d99bbc1e1d8988390047f2/cards")
                                                    (method . "GET")
                                                    (sync . t)
                                                    (name . "some name")
                                                    (id . "some id")
                                                    (action . "some action")
                                                    (level . 3)
                                                    (start . nil))))))

(expectations
 (expect "some-root-dir/some-buffername-1000.el" (orgtrello-proxy/--compute-metadata-filename "some-root-dir/" "some-buffername" 1000))
 (expect "some-root-dir/some-buffername-with-dangerous-pattern-including-!!!___orgtrello-defensive-pattern___!!!-1000.el"
         (orgtrello-proxy/--compute-metadata-filename "some-root-dir/" "some-buffername-with-dangerous-pattern-including-/" 1000)))
