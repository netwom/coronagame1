<?php


class GameGenerator
{

    const TESTING = true;

    private $testId = -1;
    private $selectedMoves = array();


    private function getAllMoves()
    {
        return array(
            'movings.zigzagTLtoDR' => array('x' => 800, 'y' => 80, 'time' => 10000, 'interval' => 500),
            'movings.zigzagTtoD' => array('x' => 80, 'y' => -50, 'time' => 8000, 'interval' => 500),
            'movings.roundD' => array('x' => 575, 'y' => -120, 'time' => 8000, 'interval' => 500),
            'movings.zigzagTRtoTL' => array('x' => 835, 'y' => 40, 'time' => 12000, 'interval' => 500),
            'movings.turnTLtoDR' => array('x' => 545, 'y' => -125, 'time' => 5000, 'interval' => 500),
            'movings.roundTRtoDR' => array('x' => 550, 'y' => -140, 'time' => 8000, 'interval' => 500),
            'movings.eightTRtoDL' => array('x' => 570, 'y' => -150, 'time' => 8000, 'interval' => 400),
        );
    }


    private function getRandomMove($maxMoves)
    {
        if (sizeof($this->selectedMoves) >= $maxMoves && !self::TESTING){
            shuffle($this->selectedMoves);
            return reset($this->selectedMoves);
        }
        $allMoves = $this->getAllMoves();
        if (self::TESTING){
            $this->testId++;
            if (sizeof($allMoves) <= $this->testId){
                $this->testId = 0;
            }
            $_cnt = -1;
            foreach($allMoves as $moveId => $move){
                $_cnt++;
                if ($_cnt == $this->testId){
                    $selectedMove = $allMoves[$moveId];
                    $selectedMove['move'] = $moveId;
                }
            }
        } else {
            $randMoveId = array_rand($allMoves);
            $selectedMove = $allMoves[$randMoveId];
            $selectedMove['move'] = $randMoveId;
            if (mt_rand(0, 1) == 1){
                $selectedMove['move'] = 'movings.invertX('.$randMoveId.')';
                $selectedMove['x'] = 640 - $selectedMove['x'];
            }
        }
        $this->selectedMoves[] = $selectedMove;
        return $selectedMove;

    }

    public function generateLevel($time, $bunches, $inBunchMin, $inBunchMax, $enemyVariations, $moveVariations)
    {
        $avTimeBetweenBunches = ($time * 1000) / $bunches;
        $str = '';
        for($i = 0; $i < $bunches; $i++){
            $timeOut = ($avTimeBetweenBunches * $i) + $avTimeBetweenBunches * (mt_rand(-25, 25) / 100);
            if ($timeOut < 0) $timeOut = 0;
            $numItemsInBunch = mt_rand($inBunchMin, $inBunchMax);
            $enemyType = mt_rand(1, $enemyVariations);
            $move = $this->getRandomMove($moveVariations);
            //{timeout = 1000, num = 4, startPosition = {800, 80}, enemyType = 1, moving = movings.zigzagTLtoDR, startTimeout = 300, time = 5000 },
            $strItem = '{timeout = '.$timeOut.', num = '.$numItemsInBunch.', startPosition = {'.$move['x'].', '.$move['y'].'}, enemyType = '.$enemyType.', moving = '.$move['move'].', startTimeout = '.$move['interval'].', time = '.$move['time'].' }, ';
            $str .= $strItem . '<br />';
        }
        return $str;
    }

}


$generator = new GameGenerator();
echo $generator->generateLevel(45, 9, 2, 3, 2, 4);