--宝玉の双璧 (Anime)
--Crystal Pair (Anime)
function c511001129.initial_effect(c)
	--Place 1 "Crystal Beast" monster from your Deck in your Spell & Trap Card Zone, face-up
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc511001129(c511001129,0))
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetCondition(c511001129.plcon)
	e1:SetTarget(c511001129.pltg)
	e1:SetOperation(c511001129.plop)
	c:RegisterEffect(e1)
end
c511001129.listed_series={SET_CRYSTAL_BEAST}
function c511001129.confilter(c,tp)
	return c:IsPreviousSetCard(SET_CRYSTAL_BEAST) and c:IsPreviousControler(tp)
end
function c511001129.plcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511001129.confilter,1,nil,tp)
end
function c511001129.plfilter(c)
	return c:IsSetCard(SET_CRYSTAL_BEAST) and c:IsMonster() and not c:IsForbc511001129den()
end
function c511001129.pltg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingMatchingCard(c511001129.plfilter,tp,LOCATION_DECK,0,1,nil) end
end
function c511001129.plop(e,tp,eg,ep,ev,re,r,rp)
	--You take no battle damage for the rest of this turn 
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetDescription(aux.Stringc511001129(c511001129,1))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CLIENT_HINT)
	e1:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	e1:SetTargetRange(1,0)
	e1:SetValue(1)
	e1:SetReset(RESET_PHASE|PHASE_END)
	Duel.RegisterEffect(e1,tp)
	if Duel.GetLocationCount(tp,LOCATION_SZONE)==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOFIELD)
	local tc=Duel.SelectMatchingCard(tp,c511001129.plfilter,tp,LOCATION_DECK,0,1,1,nil):GetFirst()
	if tc then
		Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
	end
end