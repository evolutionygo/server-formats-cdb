--超再生能力
--Super Rejuvenation
function c27770341.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(TIMING_END_PHASE)
	e1:SetOperation(c27770341.activate)
	c:RegisterEffect(e1)
	aux.GlobalCheck(s,function()
		s[0]=0
		s[1]=0
		aux.AddValuesReset(function()
			s[0]=0
			s[1]=0
		end)
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
		e3:SetCode(EVENT_RELEASE)
		e3:SetOperation(c27770341.addcount)
		Duel.RegisterEffect(e3,0)
		local e4=Effect.CreateEffect(c)
		e4:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
		e4:SetCode(EVENT_DISCARD)
		e4:SetOperation(c27770341.addcount)
		Duel.RegisterEffect(e4,0)
	end)
end
function c27770341.addcount(e,tp,eg,ep,ev,re,r,rp)
	for tc in aux.Next(eg) do
		local pl=tc:GetPreviousLocation()
		if pl==LOCATION_MZONE and tc:GetPreviousRaceOnField()==RACE_DRAGON then
			local p=tc:GetReasonPlayer()
			s[p]=s[p]+1
		elseif pl==LOCATION_HAND and tc:IsMonster() and tc:GetOriginalRace()==RACE_DRAGON then
			local p=tc:GetPreviousControler()
			s[p]=s[p]+1
		end
	end
end
function c27770341.activate(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetCountLimit(1)
	e1:SetOperation(c27770341.droperation)
	Duel.RegisterEffect(e1,tp)
end
function c27770341.droperation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,c27770341)
	Duel.Draw(tp,s[tp],REASON_EFFECT)
end