<?php

function getAllMoves()
{
    return array(
        'movings.zigzagTLtoDR' => array('x' => 800, 'y' => 80, 'time' => 5000, 'interval' => 300),
        'movings.zigzagTtoD' => array('x' => 80, 'y' => -50, 'time' => 4000, 'interval' => 300),
        'movings.roundD' => array('x' => 575, 'y' => -120, 'time' => 4000, 'interval' => 300),
        'movings.zigzagTRtoTL' => array('x' => 835, 'y' => 40, 'time' => 6000, 'interval' => 300),
        'movings.turnTLtoDR' => array('x' => 545, 'y' => -125, 'time' => 4000, 'interval' => 300),
        'movings.roundTRtoDR' => array('x' => 550, 'y' => -140, 'time' => 4000, 'interval' => 300),
        'movings.eightTRtoDL' => array('x' => 570, 'y' => -150, 'time' => 4000, 'interval' => 300),
    );
}

function getRandomMove($maxMoves)
{
    static $selectedMoves;
    if (sizeof($selectedMoves) >= $maxMoves){
        shuffle($selectedMoves);
        return reset($selectedMoves);
    }
    $allMoves = getAllMoves();
    $randMoveId = array_rand($allMoves);
    $selectedMove = $allMoves[$randMoveId];
    $selectedMove['move'] = $randMoveId;
    if (mt_rand(0, 1) == 1){
        $selectedMove['move'] = 'movings.invertX('.$randMoveId.')';
        $selectedMove['x'] = 640 - $selectedMove['x'];
    }
    $selectedMoves[] = $selectedMove;
    return $selectedMove;

}

function generateLevel($time, $bunches, $inBunchMin, $inBunchMax, $enemyVariations, $moveVariations)
{
    $avTimeBetweenBunches = ($time * 1000) / $bunches;
    $str = '';
    for($i = 0; $i < $bunches; $i++){
        $timeOut = ($avTimeBetweenBunches * $i) + $avTimeBetweenBunches * (mt_rand(-25, 25) / 100);
        if ($timeOut < 0) $timeOut = 0;
        $numItemsInBunch = mt_rand($inBunchMin, $inBunchMax);
        $enemyType = mt_rand(1, $enemyVariations);
        $move = getRandomMove($moveVariations);
        //{timeout = 1000, num = 4, startPosition = {800, 80}, enemyType = 1, moving = movings.zigzagTLtoDR, startTimeout = 300, time = 5000 },
        $strItem = '{timeout = '.$timeOut.', num = '.$numItemsInBunch.', startPosition = {'.$move['x'].', '.$move['y'].'}, enemyType = '.$enemyType.', moving = '.$move['move'].', startTimeout = '.$move['interval'].', time = '.$move['time'].' }, ';
        $str .= $strItem . '<br />';
    }
    return $str;
}

echo generateLevel(45, 9, 2, 3, 2, 4);