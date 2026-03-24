pipeline {
    agent any

    stages {
        stage('Prepare') {
            steps {
                sh '''
                    mkdir -p results
                    chmod +x scripts/*.sh
                '''
            }
        }

        stage('Start Source App') {
            steps {
                sh './scripts/start_source.sh'
                sh 'sleep 15'
            }
        }

        stage('Start Target App') {
            steps {
                sh './scripts/start_target.sh'
                sh 'sleep 15'
            }
        }

        stage('Start GoReplay') {
            steps {
                sh './scripts/run_gor.sh'
                sh 'sleep 15'
            }
        }

        stage('Run wrk Normal Test') {
            steps {
                sh './scripts/run_wrk.sh normal'
            }
        }

        stage('Run wrk Another Normal Test') {
            steps {
                sh './scripts/run_wrk.sh another_normal'
            }
        }

        stage('Run wrk Slow Test') {
            steps {
                sh './scripts/run_wrk.sh slow'
            }
        }

        stage('Run wrk Error Test') {
            steps {
                sh './scripts/run_wrk.sh error'
            }
        }

        stage('Collect Basic System Stats') {
            steps {
                sh '''
            mkdir -p results

            if [ "$(uname)" = "Darwin" ]; then
                top -l 1 > results/system_top.txt || true
                vm_stat > results/system_vmstat.txt || true
            else
                top -b -n 1 > results/system_top.txt || true
                vmstat > results/system_vmstat.txt || true
            fi

            ls -lh results > results/results_listing.txt
                '''
            }
        }
    }

    post {
        always {
            sh './scripts/stop_all.sh || true'
            archiveArtifacts artifacts: 'results/**', fingerprint: true
        }
    }
}