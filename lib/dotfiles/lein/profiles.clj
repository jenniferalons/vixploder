{:user
 {:plugins [[jonase/eastwood "0.2.1"]
            [com.palletops/lein-shorthand "0.4.0"]
            [org.clojure/tools.namespace "0.2.10"]
            ]
  :dependencies [[com.gfredericks/repl-utils "0.2.4"]
                 [com.gfredericks/debug-repl "0.0.6"]
                 [org.clojure/tools.nrepl "0.2.8"]
                 ]
  :repl-options {:nrepl-middleware
                 [com.gfredericks.debug-repl/wrap-debug-repl]}
  :shorthand {. [clojure.repl/apropos
                 clojure.repl/doc
                 clojure.repl/pst
                 clojure.test/run-tests
                 clojure.repl/source
                 com.gfredericks.repl.bg/bg
                 com.gfredericks.repl/dir
                 com.gfredericks.repl/run-all-tests
                 clojure.tools.namespace.repl/refresh
                 com.gfredericks.debug-repl/break!
                 com.gfredericks.debug-repl/unbreak!
                 com.gfredericks.debug-repl/unbreak!!
                 ]}}}