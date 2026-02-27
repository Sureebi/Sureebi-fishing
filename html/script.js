// console.log('[Minigame] Script loaded');

let currentMinigame = null;
let minigameActive = false;

window.addEventListener('message', function(event) {
    const data = event.data;
    // console.log('[Minigame] Message received:', data);
    
    if (data.action === 'startMinigame') {
        startMinigame(data.rarity);
    } else if (data.action === 'closeMinigame') {
        closeMinigame();
    }
});

function startMinigame(rarity) {
    // console.log('[Minigame] Starting:', rarity);
    minigameActive = true;
    currentMinigame = rarity.toLowerCase();
    
    document.querySelectorAll('.minigame-container').forEach(el => {
        el.classList.remove('show');
    });
    
    switch(currentMinigame) {
        case 'common':
            startCommonMinigame();
            break;
        case 'uncommon':
            startUncommonMinigame();
            break;
        case 'rare':
            startRareMinigame();
            break;
        case 'epic':
            startEpicMinigame();
            break;
        case 'trash':
            // Trash is automatic success (no minigame needed)
            // console.log('[Minigame] Trash - auto success');
            setTimeout(() => sendResult(true), 500);
            break;
        default:
            // Unknown rarity - default to common
            // console.log('[Minigame] Unknown rarity, defaulting to common');
            startCommonMinigame();
            break;
    }
}

function closeMinigame() {
    // console.log('[Minigame] Closing');
    minigameActive = false;
    document.querySelectorAll('.minigame-container').forEach(el => {
        el.classList.remove('show');
    });
}

// Helper to get resource name
function GetParentResourceName() {
    if (window.location.hostname && window.location.hostname !== '') {
        const hostname = window.location.hostname;
        if (hostname.startsWith('cfx-nui-')) {
            return hostname.replace('cfx-nui-', '');
        }
        return hostname;
    }
    return 'tmw_fishing';
}

function sendResult(success) {
    // console.log('[Minigame] Sending result:', success);
    
    fetch(`https://${GetParentResourceName()}/minigameResult`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ success: success })
    });
    
    closeMinigame();
}

// Common Minigame - Multiple rounds
function startCommonMinigame() {
    const container = document.getElementById('common-minigame');
    container.classList.add('show');
    
    const indicator = document.getElementById('timing-indicator');
    const target = document.getElementById('timing-target');
    const title = container.querySelector('.minigame-title');
    
    let totalRounds = 3 + Math.floor(Math.random() * 3); // 3-5 rounds
    let currentRound = 0;
    let successfulRounds = 0;
    let completed = false;
    
    function startRound() {
        if (currentRound >= totalRounds || completed) {
            // Check if player succeeded (need at least 60% success)
            const requiredSuccess = Math.ceil(totalRounds * 0.6);
            const success = successfulRounds >= requiredSuccess;
            sendResult(success);
            return;
        }
        
        currentRound++;
        title.textContent = `ХВАНИ РИБАТА! (${currentRound}/${totalRounds})`;
        
        const targetPos = 20 + Math.random() * 50;
        const targetWidth = 18;
        target.style.left = targetPos + '%';
        target.style.width = targetWidth + '%';
        
        indicator.style.animation = 'none';
        setTimeout(() => {
            indicator.style.animation = 'slide 6s linear infinite';  // Променено от 4s на 6s
        }, 10);
        
        let roundCompleted = false;
        
        const handleSpace = (e) => {
            if (e.code === 'Space' && !roundCompleted) {
                roundCompleted = true;
                
                const indicatorRect = indicator.getBoundingClientRect();
                const targetRect = target.getBoundingClientRect();
                
                // Check if ANY part of the indicator overlaps with the target
                const indicatorLeft = indicatorRect.left;
                const indicatorRight = indicatorRect.right;
                const targetLeft = targetRect.left;
                const targetRight = targetRect.right;
                
                // Success if there's ANY overlap
                const success = (indicatorLeft <= targetRight && indicatorRight >= targetLeft);
                
                // console.log('[Common Minigame] Click check:', {
                //     indicatorLeft: indicatorLeft,
                //     indicatorRight: indicatorRight,
                //     targetLeft: targetLeft,
                //     targetRight: targetRight,
                //     overlap: success
                // });
                
                if (success) {
                    successfulRounds++;
                    target.style.background = 'rgba(157, 255, 123, 0.5)';
                    target.style.borderColor = 'rgba(157, 255, 123, 0.8)';
                } else {
                    target.style.background = 'rgba(255, 107, 107, 0.3)';
                    target.style.borderColor = 'rgba(255, 107, 107, 0.6)';
                }
                
                document.removeEventListener('keydown', handleSpace);
                
                setTimeout(() => {
                    target.style.background = 'rgba(157, 255, 123, 0.25)';
                    target.style.borderColor = 'rgba(157, 255, 123, 0.6)';
                    startRound();
                }, 500);
            }
        };
        
        document.addEventListener('keydown', handleSpace);
        
        setTimeout(() => {
            if (!roundCompleted && !completed) {
                roundCompleted = true;
                document.removeEventListener('keydown', handleSpace);
                // Missed round - continue to next
                setTimeout(startRound, 500);
            }
        }, 15000); // Increased from 10s to 15s
    }
    
    startRound();
    
    // Overall timeout
    setTimeout(() => {
        if (!completed) {
            completed = true;
            sendResult(false);
        }
    }, 90000); // Increased from 60s to 90s
}

// Uncommon Minigame - Multiple rounds with WASD
function startUncommonMinigame() {
    const container = document.getElementById('uncommon-minigame');
    container.classList.add('show');
    
    const sequenceContainer = document.getElementById('sequence-container');
    const title = container.querySelector('.minigame-title');
    
    const keys = ['W', 'D', 'S', 'A'];
    const arrowKeys = ['KeyW', 'KeyD', 'KeyS', 'KeyA'];
    
    let totalRounds = 2 + Math.floor(Math.random() * 3); // 2-4 rounds
    let currentRound = 0;
    let successfulRounds = 0;
    let completed = false;
    
    function startRound() {
        if (currentRound >= totalRounds || completed) {
            // Check if player succeeded (need at least 60% success)
            const requiredSuccess = Math.ceil(totalRounds * 0.6);
            const success = successfulRounds >= requiredSuccess;
            sendResult(success);
            return;
        }
        
        currentRound++;
        title.textContent = `НАВИЙ ВЪДИЦАТА! (${currentRound}/${totalRounds})`;
        
        sequenceContainer.innerHTML = '';
        
        const sequenceLength = 4 + Math.floor(Math.random() * 2);
        const sequence = [];
        
        for (let i = 0; i < sequenceLength; i++) {
            const randomIndex = Math.floor(Math.random() * 4);
            sequence.push(randomIndex);
            
            const keyDiv = document.createElement('div');
            keyDiv.className = 'sequence-arrow';
            keyDiv.textContent = keys[randomIndex];
            sequenceContainer.appendChild(keyDiv);
        }
        
        let currentIndex = 0;
        let roundCompleted = false;
        
        sequenceContainer.children[0].classList.add('active');
        
        const handleKey = (e) => {
            if (roundCompleted || completed) return;
            
            const expectedKey = arrowKeys[sequence[currentIndex]];
            const currentKeyDiv = sequenceContainer.children[currentIndex];
            
            if (e.code === expectedKey) {
                currentKeyDiv.classList.remove('active');
                currentKeyDiv.classList.add('correct');
                currentIndex++;
                
                if (currentIndex >= sequence.length) {
                    // Round completed successfully
                    roundCompleted = true;
                    successfulRounds++;
                    document.removeEventListener('keydown', handleKey);
                    setTimeout(() => startRound(), 800);
                } else {
                    sequenceContainer.children[currentIndex].classList.add('active');
                }
            } else if (arrowKeys.includes(e.code)) {
                // Wrong key pressed
                currentKeyDiv.classList.add('wrong');
                roundCompleted = true;
                document.removeEventListener('keydown', handleKey);
                setTimeout(() => startRound(), 800);
            }
        };
        
        document.addEventListener('keydown', handleKey);
        
        setTimeout(() => {
            if (!roundCompleted && !completed) {
                roundCompleted = true;
                document.removeEventListener('keydown', handleKey);
                // Timeout - continue to next round
                setTimeout(() => startRound(), 500);
            }
        }, 30000); // Increased from 20s to 30s
    }
    
    startRound();
    
    // Overall timeout
    setTimeout(() => {
        if (!completed) {
            completed = true;
            sendResult(false);
        }
    }, 120000); // Increased from 90s to 120s (2 minutes)
}

// Rare Minigame - Simple Pattern (3 repetitions)
function startRareMinigame() {
    const container = document.getElementById('rare-minigame');
    container.classList.add('show');
    
    const patternDisplay = document.getElementById('rare-pattern-display');
    const phaseDisplay = document.getElementById('rare-pattern-phase');
    const inputDisplay = document.getElementById('rare-pattern-input');
    const title = container.querySelector('.minigame-title');
    
    const keys = ['W', 'A', 'S', 'D'];
    const keyCodes = ['KeyW', 'KeyA', 'KeyS', 'KeyD'];
    const keyElements = patternDisplay.querySelectorAll('.pattern-key');
    
    let totalRounds = 3; // 3 повторения
    let currentRound = 0;
    let successfulRounds = 0;
    let completed = false;
    
    function startRound() {
        if (currentRound >= totalRounds || completed) {
            const success = successfulRounds >= 2; // Трябват 2 от 3
            sendResult(success);
            return;
        }
        
        currentRound++;
        title.textContent = `ЗАПОМНИ PATTERN-А! (${currentRound}/${totalRounds})`;
        
        const patternLength = 3; // 3 клавиша (по-трудно)
        const pattern = [];
        
        for (let i = 0; i < patternLength; i++) {
            pattern.push(Math.floor(Math.random() * 4));
        }
        
        // Phase 1: Show pattern
        phaseDisplay.textContent = 'Гледай внимателно...';
        inputDisplay.textContent = '';
        
        let showIndex = 0;
        const showInterval = setInterval(() => {
            // Clear previous
            keyElements.forEach(el => el.classList.remove('flash'));
            
            if (showIndex < pattern.length) {
                keyElements[pattern[showIndex]].classList.add('flash');
                showIndex++;
            } else {
                clearInterval(showInterval);
                keyElements.forEach(el => el.classList.remove('flash'));
                
                // Phase 2: Player input
                setTimeout(() => {
                    phaseDisplay.textContent = 'Твой ред! Повтори pattern-а';
                    
                    let playerInput = [];
                    let roundCompleted = false;
                    
                    const handleInput = (e) => {
                        if (roundCompleted || completed) return;
                        
                        const keyIndex = keyCodes.indexOf(e.code);
                        if (keyIndex === -1) return;
                        
                        playerInput.push(keyIndex);
                        inputDisplay.textContent = playerInput.map(i => keys[i]).join(' ');
                        
                        // Flash the key
                        keyElements[keyIndex].classList.add('flash');
                        setTimeout(() => {
                            keyElements[keyIndex].classList.remove('flash');
                        }, 200);
                        
                        // Check if correct so far
                        const currentIndex = playerInput.length - 1;
                        if (playerInput[currentIndex] !== pattern[currentIndex]) {
                            // Wrong!
                            roundCompleted = true;
                            keyElements[keyIndex].classList.add('wrong');
                            phaseDisplay.textContent = 'Грешка!';
                            document.removeEventListener('keydown', handleInput);
                            
                            setTimeout(() => {
                                keyElements.forEach(el => el.classList.remove('wrong'));
                                startRound();
                            }, 1500);
                            return;
                        }
                        
                        // Check if complete
                        if (playerInput.length === pattern.length) {
                            // Success!
                            roundCompleted = true;
                            successfulRounds++;
                            keyElements.forEach(el => el.classList.add('correct'));
                            phaseDisplay.textContent = 'Перфектно!';
                            document.removeEventListener('keydown', handleInput);
                            
                            setTimeout(() => {
                                keyElements.forEach(el => el.classList.remove('correct'));
                                startRound();
                            }, 1500);
                        }
                    };
                    
                    document.addEventListener('keydown', handleInput);
                    
                    setTimeout(() => {
                        if (!roundCompleted && !completed) {
                            roundCompleted = true;
                            document.removeEventListener('keydown', handleInput);
                            phaseDisplay.textContent = 'Време изтече!';
                            setTimeout(() => startRound(), 1500);
                        }
                    }, 20000); // 20 секунди за въвеждане
                }, 1000);
            }
        }, 800); // По-бързо показване (800ms вместо 1000ms)
    }
    
    startRound();
    
    setTimeout(() => {
        if (!completed) {
            completed = true;
            sendResult(false);
        }
    }, 90000); // 90 секунди общо време
}

// Epic Minigame - 4 повторения, 5 удара всяко
function startEpicMinigame() {
    const container = document.getElementById('epic-minigame');
    container.classList.add('show');
    
    const keyElements = container.querySelectorAll('.reaction-key-epic');
    const scoreDisplay = document.getElementById('epic-reaction-score');
    const title = container.querySelector('.minigame-title');
    
    const keys = ['W', 'A', 'S', 'D'];
    const keyCodes = ['KeyW', 'KeyA', 'KeyS', 'KeyD'];
    
    let totalRounds = 4; // 4 повторения
    let currentRound = 0;
    let completed = false;
    
    function startRound() {
        if (currentRound >= totalRounds || completed) {
            // All rounds completed successfully
            title.textContent = 'УСПЯ!';
            setTimeout(() => sendResult(true), 1000);
            return;
        }
        
        currentRound++;
        title.textContent = `БЪРЗА РЕАКЦИЯ! (${currentRound}/${totalRounds})`;
        
        let score = 0;
        const requiredScore = 5; // Трябват 5 правилни удара
        let attempts = 0;
        const maxAttempts = 7; // Максимум 7 опита
        let roundCompleted = false;
        
        scoreDisplay.textContent = score + '/' + requiredScore;
        
        function showRandomKey() {
            if (roundCompleted || completed || attempts >= maxAttempts) {
                if (score >= requiredScore) {
                    // Success! Next round
                    setTimeout(() => startRound(), 1000);
                } else {
                    // Failed round
                    completed = true;
                    title.textContent = 'НЕ УСПЯ!';
                    setTimeout(() => sendResult(false), 1500);
                }
                return;
            }
            
            attempts++;
            
            // Clear all active states
            keyElements.forEach(el => {
                el.classList.remove('active', 'success', 'fail');
            });
            
            // Random key
            const randomIndex = Math.floor(Math.random() * 4);
            const activeKey = keyElements[randomIndex];
            activeKey.classList.add('active');
            
            let keyPressed = false;
            const startTime = Date.now();
            const reactionWindow = 1500; // 1.5 секунди (по-трудно)
            
            const handleKey = (e) => {
                if (keyPressed || roundCompleted || completed) return;
                
                const keyIndex = keyCodes.indexOf(e.code);
                if (keyIndex === -1) return;
                
                keyPressed = true;
                const reactionTime = Date.now() - startTime;
                
                // Clear active state
                activeKey.classList.remove('active');
                
                if (keyIndex === randomIndex && reactionTime <= reactionWindow) {
                    // Correct!
                    score++;
                    scoreDisplay.textContent = score + '/' + requiredScore;
                    keyElements[keyIndex].classList.add('success');
                    
                    if (score >= requiredScore) {
                        roundCompleted = true;
                    }
                } else {
                    // Wrong key or too slow
                    keyElements[keyIndex].classList.add('fail');
                }
                
                document.removeEventListener('keydown', handleKey);
                
                setTimeout(() => {
                    keyElements.forEach(el => el.classList.remove('success', 'fail'));
                    showRandomKey();
                }, 400); // По-бързо (400ms вместо 500ms)
            };
            
            document.addEventListener('keydown', handleKey);
            
            // Auto-fail if no key pressed
            setTimeout(() => {
                if (!keyPressed && !roundCompleted && !completed) {
                    keyPressed = true;
                    activeKey.classList.remove('active');
                    activeKey.classList.add('fail');
                    document.removeEventListener('keydown', handleKey);
                    
                    setTimeout(() => {
                        activeKey.classList.remove('fail');
                        showRandomKey();
                    }, 400);
                }
            }, 1500); // 1.5 секунди
        }
        
        // Start first key after short delay
        setTimeout(() => showRandomKey(), 800); // По-бързо стартиране
    }
    
    startRound();
    
    setTimeout(() => {
        if (!completed) {
            completed = true;
            sendResult(false);
        }
    }, 120000); // 2 минути общо време
}

// ESC to close
document.addEventListener('keydown', (e) => {
    if (e.code === 'Escape' && minigameActive) {
        sendResult(false);
    }
});

// console.log('[Minigame] Script initialized');
