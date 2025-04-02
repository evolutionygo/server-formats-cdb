--幻獣機オライオン
--Mecha Phantom Beast O-Lion
function c72291078.initial_effect(c)
	--Cannot be destroyed by battle or effects while you control a Token
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetCondition(c72291078.indcon)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	c:RegisterEffect(e2)
	--Normal Summon 1 "Mecha phantom Beast" monster
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringc72291078(c72291078,0))
	e3:SetCategory(CATEGORY_SUMMON)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_GRAVE)
	e3:SetCost(aux.bfgcost)
	e3:SetTarget(c72291078.target)
	e3:SetOperation(c72291078.operation)
	c:RegisterEffect(e3)
	--Special Summon 1 "Mecha Phantom Beast" token
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringc72291078(c72291078,1))
	e4:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e4:SetProperty(EFFECT_FLAG_DELAY)
	e4:SetCode(EVENT_TO_GRAVE)
	e4:SetCountLimit(1,c72291078)
	e4:SetTarget(c72291078.sptg)
	e4:SetOperation(c72291078.spop)
	c:RegisterEffect(e4)
end
c72291078.listed_series={SET_MECHA_PHANTOM_BEAST}
c72291078.listed_names={TOKEN_MECHA_PHANTOM_BEAST}
function c72291078.tknfilter(c)
	return c:IsType(TYPE_TOKEN) or c:IsOriginalType(TYPE_TOKEN)
end
function c72291078.indcon(e)
	return Duel.IsExistingMatchingCard(c72291078.tknfilter,e:GetHandlerPlayer(),LOCATION_ONFIELD,0,1,nil)
end
function c72291078.filter(c)
	return c:IsSetCard(SET_MECHA_PHANTOM_BEAST) and c:IsSummonable(true,nil)
end
function c72291078.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c72291078.filter,tp,LOCATION_HAND,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_SUMMON,nil,1,0,0)
end
function c72291078.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SUMMON)
	local tc=Duel.SelectMatchingCard(tp,c72291078.filter,tp,LOCATION_HAND,0,1,1,nil):GetFirst()
	if tc then
		Duel.Summon(tp,tc,true,nil)
	end
end
function c72291078.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,TOKEN_MECHA_PHANTOM_BEAST,SET_MECHA_PHANTOM_BEAST,TYPES_TOKEN,0,0,3,RACE_MACHINE,ATTRIBUTE_WIND) end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,0)
end
function c72291078.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>0 
		and Duel.IsPlayerCanSpecialSummonMonster(tp,TOKEN_MECHA_PHANTOM_BEAST,SET_MECHA_PHANTOM_BEAST,TYPES_TOKEN,0,0,3,RACE_MACHINE,ATTRIBUTE_WIND) then
		local token=Duel.CreateToken(tp,TOKEN_MECHA_PHANTOM_BEAST)
		Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP)
	end
end