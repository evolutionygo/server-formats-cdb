--強制終了
--Scrubbed Rac79205581
function c79205581.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--End the Battle Phase
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringc79205581(c79205581,0))
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetCondition(c79205581.bpcon)
	e2:SetCost(c79205581.bpcost)
	e2:SetOperation(c79205581.bpop)
	c:RegisterEffect(e2)
end
function c79205581.bpcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsBattlePhase() and Duel.GetCurrentPhase()<PHASE_BATTLE
end
function c79205581.bpcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToGraveAsCost,tp,LOCATION_ONFIELD,0,1,e:GetHandler())
		and e:GetHandler():GetFlagEffect(c79205581)==0 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,Card.IsAbleToGraveAsCost,tp,LOCATION_ONFIELD,0,1,1,e:GetHandler())
	Duel.SendtoGrave(g,REASON_COST)
	e:GetHandler():RegisterFlagEffect(c79205581,RESET_EVENT+RESET_CHAIN,0,1)
end
function c79205581.bpop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	Duel.SkipPhase(Duel.GetTurnPlayer(),PHASE_BATTLE,RESET_PHASE+PHASE_BATTLE_STEP,1)
end