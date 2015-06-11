{:user
 {:plugins [[jonase/eastwood "0.2.1"]
            [com.palletops/lein-shorthand "0.4.0"]
            [org.clojure/tools.namespace "0.2.10"]
            ]
  :dependencies [[com.gfredericks/repl-utils "0.2.4"]]
  :shorthand {. [com.gfredericks.repl.bg/bg
                 com.gfredericks.repl/run-all-tests
                 clojure.tools.namespace.repl/refresh
                 ]}}}
