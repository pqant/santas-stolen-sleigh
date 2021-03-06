<?xml version="1.0" encoding="UTF-8"?>
<plannerBenchmark>
  <benchmarkDirectory>local/data/sss/template</benchmarkDirectory>
    <parallelBenchmarkCount>AUTO</parallelBenchmarkCount>
    <warmUpSecondsSpentLimit>30</warmUpSecondsSpentLimit>

    <inheritedSolverBenchmark>
        <problemBenchmarks>
            <!--<writeOutputSolutionEnabled>true</writeOutputSolutionEnabled>-->

            <solutionFileIOClass>org.optaplannerdelirium.sss.persistence.ReindeerRoutingFileIO</solutionFileIOClass>
            <!-- Slices datasets -->
            <!--<inputSolutionFile>data/sss/import/slices/gifts_slice0.csv</inputSolutionFile>-->
            <!--<inputSolutionFile>data/sss/import/slices/gifts_slice1.csv</inputSolutionFile>-->
            <!--<inputSolutionFile>data/sss/import/slices/gifts_slice2.csv</inputSolutionFile>-->
            <!--<inputSolutionFile>data/sss/import/slices/gifts_slice3.csv</inputSolutionFile>-->
            <!--<inputSolutionFile>data/sss/import/slices/gifts_slice4.csv</inputSolutionFile>-->
            <inputSolutionFile>data/sss/import/slices/gifts_slice5.csv</inputSolutionFile>
            <!--<inputSolutionFile>data/sss/import/slices/gifts_slice6.csv</inputSolutionFile>-->
            <!--<inputSolutionFile>data/sss/import/slices/gifts_slice7.csv</inputSolutionFile>-->
            <!--<inputSolutionFile>data/sss/import/slices/gifts_slice8.csv</inputSolutionFile>-->
            <!--<inputSolutionFile>data/sss/import/slices/gifts_slice9.csv</inputSolutionFile>-->
            <!--<inputSolutionFile>data/sss/import/slices/gifts_slice10.csv</inputSolutionFile>-->
            <!--<inputSolutionFile>data/sss/import/slices/gifts_slice11.csv</inputSolutionFile>-->
            <!--<inputSolutionFile>data/sss/import/slices/gifts_slice12.csv</inputSolutionFile>-->
            <!--<inputSolutionFile>data/sss/import/slices/gifts_slice13.csv</inputSolutionFile>-->
            <!--<inputSolutionFile>data/sss/import/slices/gifts_slice14.csv</inputSolutionFile>-->
            <!--<inputSolutionFile>data/sss/import/slices/gifts_slice15.csv</inputSolutionFile>-->
            <!--<inputSolutionFile>data/sss/import/slices/gifts_slice16.csv</inputSolutionFile>-->
            <!--<inputSolutionFile>data/sss/import/slices/gifts_slice17.csv</inputSolutionFile>-->
            <!--<inputSolutionFile>data/sss/import/slices/gifts_slice18.csv</inputSolutionFile>-->
            <!--<inputSolutionFile>data/sss/import/slices/gifts_slice19.csv</inputSolutionFile>-->
            <!-- Chunks datasets -->
            <!--<inputSolutionFile>data/sss/import/chunks/gifts_chunk0.csv</inputSolutionFile>-->
            <!--<inputSolutionFile>data/sss/import/chunks/gifts_chunk1.csv</inputSolutionFile>-->
            <!--<inputSolutionFile>data/sss/import/chunks/gifts_chunk2.csv</inputSolutionFile>-->
            <!--<inputSolutionFile>data/sss/import/chunks/gifts_chunk3.csv</inputSolutionFile>-->
            <!--<inputSolutionFile>data/sss/import/chunks/gifts_chunk4.csv</inputSolutionFile>-->
            <problemStatisticType>BEST_SCORE</problemStatisticType>
            <!--<problemStatisticType>STEP_SCORE</problemStatisticType>-->
            <!--<problemStatisticType>CALCULATE_COUNT_PER_SECOND</problemStatisticType>-->
            <!--<problemStatisticType>BEST_SOLUTION_MUTATION</problemStatisticType>-->
            <!--<problemStatisticType>MOVE_COUNT_PER_STEP</problemStatisticType>-->
            <!--<problemStatisticType>MEMORY_USE</problemStatisticType>-->
            <!--<singleStatisticType>CONSTRAINT_MATCH_TOTAL_BEST_SCORE</singleStatisticType>-->
            <!--<singleStatisticType>CONSTRAINT_MATCH_TOTAL_STEP_SCORE</singleStatisticType>-->
            <!--<singleStatisticType>PICKED_MOVE_TYPE_BEST_SCORE_DIFF</singleStatisticType>-->
            <!--<singleStatisticType>PICKED_MOVE_TYPE_STEP_SCORE_DIFF</singleStatisticType>-->
        </problemBenchmarks>

        <solver>
            <!--<environmentMode>FULL_ASSERT</environmentMode>-->
            <solutionClass>org.optaplannerdelirium.sss.domain.ReindeerRoutingSolution</solutionClass>
            <entityClass>org.optaplannerdelirium.sss.domain.Standstill</entityClass>
            <entityClass>org.optaplannerdelirium.sss.domain.GiftAssignment</entityClass>

            <scoreDirectorFactory>
                <scoreDefinitionType>HARD_SOFT_LONG</scoreDefinitionType>
                <!--<easyScoreCalculatorClass>org.optaplannerdelirium.sss.solver.score.ReindeerRoutingEasyScoreCalculator</easyScoreCalculatorClass>-->
                <incrementalScoreCalculatorClass>org.optaplannerdelirium.sss.solver.score.ReindeerRoutingIncrementalScoreCalculator</incrementalScoreCalculatorClass>
                <!--<assertionScoreDirectorFactory>-->
                <!--<easyScoreCalculatorClass>org.optaplannerdelirium.sss.solver.score.ReindeerRoutingEasyScoreCalculator</easyScoreCalculatorClass>-->
                <!--</assertionScoreDirectorFactory>-->
                <initializingScoreTrend>ONLY_DOWN</initializingScoreTrend>
            </scoreDirectorFactory>

            <termination>
              <minutesSpentLimit>60</minutesSpentLimit>
            </termination>
            <customPhase>
                <!-- First initialize the big gifts to give each their own reindeer -->
                <customPhaseCommandClass>org.optaplannerdelirium.sss.solver.custom.BigGiftInitializer</customPhaseCommandClass>
            </customPhase>
            <constructionHeuristic>
                <!-- Then initialize the rest -->
                <constructionHeuristicType>FIRST_FIT_DECREASING</constructionHeuristicType>
            </constructionHeuristic>
        </solver>
    </inheritedSolverBenchmark>

<#list [7, 9] as entityTabuSize>
  <solverBenchmark>
    <name>Tabu Search ${entityTabuSize} Nearby</name>
    <solver>
      <localSearch>
        <unionMoveSelector>
          <changeMoveSelector>
            <entitySelector id="entitySelector1"/>
            <valueSelector>
              <nearbySelection>
                <originEntitySelector mimicSelectorRef="entitySelector1"/>
                <nearbyDistanceMeterClass>org.optaplannerdelirium.sss.solver.nearby.EuclideanGiftAssignmentNearbyDistanceMeter</nearbyDistanceMeterClass>
                <parabolicDistributionSizeMaximum>40</parabolicDistributionSizeMaximum>
              </nearbySelection>
            </valueSelector>
          </changeMoveSelector>
          <swapMoveSelector>
            <entitySelector id="entitySelector2"/>
            <secondaryEntitySelector>
              <nearbySelection>
                <originEntitySelector mimicSelectorRef="entitySelector2"/>
                <nearbyDistanceMeterClass>org.optaplannerdelirium.sss.solver.nearby.EuclideanGiftAssignmentNearbyDistanceMeter</nearbyDistanceMeterClass>
                <parabolicDistributionSizeMaximum>40</parabolicDistributionSizeMaximum>
              </nearbySelection>
            </secondaryEntitySelector>
          </swapMoveSelector>
          <tailChainSwapMoveSelector>
            <entitySelector id="entitySelector3"/>
            <valueSelector>
              <nearbySelection>
                <originEntitySelector mimicSelectorRef="entitySelector3"/>
                <nearbyDistanceMeterClass>org.optaplannerdelirium.sss.solver.nearby.EuclideanGiftAssignmentNearbyDistanceMeter</nearbyDistanceMeterClass>
                <parabolicDistributionSizeMaximum>40</parabolicDistributionSizeMaximum>
              </nearbySelection>
            </valueSelector>
          </tailChainSwapMoveSelector>
        </unionMoveSelector>
        <acceptor>
          <entityTabuSize>${entityTabuSize}</entityTabuSize>
        </acceptor>
        <forager>
          <acceptedCountLimit>2000</acceptedCountLimit>
        </forager>
      </localSearch>
    </solver>
  </solverBenchmark>
</#list>
<#list [100, 200, 400] as lateAcceptanceSize>
  <solverBenchmark>
    <name>Late Acceptance ${lateAcceptanceSize} Nearby</name>
    <solver>
      <localSearch>
        <unionMoveSelector>
          <changeMoveSelector>
            <entitySelector id="entitySelector1"/>
            <valueSelector>
              <nearbySelection>
                <originEntitySelector mimicSelectorRef="entitySelector1"/>
                <nearbyDistanceMeterClass>org.optaplannerdelirium.sss.solver.nearby.EuclideanGiftAssignmentNearbyDistanceMeter</nearbyDistanceMeterClass>
                <parabolicDistributionSizeMaximum>40</parabolicDistributionSizeMaximum>
              </nearbySelection>
            </valueSelector>
          </changeMoveSelector>
          <swapMoveSelector>
            <entitySelector id="entitySelector2"/>
            <secondaryEntitySelector>
              <nearbySelection>
                <originEntitySelector mimicSelectorRef="entitySelector2"/>
                <nearbyDistanceMeterClass>org.optaplannerdelirium.sss.solver.nearby.EuclideanGiftAssignmentNearbyDistanceMeter</nearbyDistanceMeterClass>
                <parabolicDistributionSizeMaximum>40</parabolicDistributionSizeMaximum>
              </nearbySelection>
            </secondaryEntitySelector>
          </swapMoveSelector>
          <tailChainSwapMoveSelector>
            <entitySelector id="entitySelector3"/>
            <valueSelector>
              <nearbySelection>
                <originEntitySelector mimicSelectorRef="entitySelector3"/>
                <nearbyDistanceMeterClass>org.optaplannerdelirium.sss.solver.nearby.EuclideanGiftAssignmentNearbyDistanceMeter</nearbyDistanceMeterClass>
                <parabolicDistributionSizeMaximum>40</parabolicDistributionSizeMaximum>
              </nearbySelection>
            </valueSelector>
          </tailChainSwapMoveSelector>
        </unionMoveSelector>
        <acceptor>
          <lateAcceptanceSize>${lateAcceptanceSize}</lateAcceptanceSize>
        </acceptor>
        <forager>
          <acceptedCountLimit>1</acceptedCountLimit>
        </forager>
      </localSearch>
    </solver>
  </solverBenchmark>
</#list>
</plannerBenchmark>
