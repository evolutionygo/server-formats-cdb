--超能力治療
function c49980185.initial_effect(c)
	--recover
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCategory(CATEGORY_RECOVER)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(TIMING_END_PHASE)
	e1:SetCondition(c49980185.reccon)
	e1:SetTarget(c49980185.rectg)
	e1:SetOperation(c49980185.recop)
	c:RegisterEffect(e1)
	aux.GlobalCheck(s,function()
		s[0]=0
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_TO_GRAVE)
		ge1:SetOperation(c49980185.checkop)
		Duel.RegisterEffect(ge1,0)
		aux.AddValuesReset(function()
			s[0]=0
		end)
	end)
end
function c49980185.checkop(e,tp,eg,ep,ev,re,r,rp)
	s[0]=s[0]+eg:FilterCount(Card.IsRace,nil,RACE_PSYCHIC)
end
function c49980185.reccon(e,tp,eg,ep,ev,re,r,rp,chk)
	return Duel.GetCurrentPhase()==PHASE_END
end
function c49980185.rectg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return s[0]~=0 end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(s[0]*1000)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,s[0]*1000)
end
function c49980185.recop(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	Duel.Recover(p,s[0]*1000,REASON_EFFECT)
end