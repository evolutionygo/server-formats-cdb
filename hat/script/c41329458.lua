--幻獣機グリーフィン
--Mecha Phantom Beast Kalgriffin
function c41329458.initial_effect(c)
	--Special Summon this card from the hand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc41329458(c41329458,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,c41329458)
	e1:SetCost(c41329458.spcost)
	e1:SetTarget(c41329458.sptg)
	e1:SetOperation(c41329458.spop)
	c:RegisterEffect(e1)
	--Cannot be destroyed by battle or card effect while you control a Token
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetCondition(c41329458.indcon)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	c:RegisterEffect(e3)
	--Special Summon 1 "Mecha Phantom Beast" Token
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringc41329458(c41329458,1))
	e4:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCountLimit(1)
	e4:SetCost(c41329458.spcost2)
	e4:SetTarget(c41329458.sptg2)
	e4:SetOperation(c41329458.spop2)
	c:RegisterEffect(e4)
end
c41329458.listed_names={TOKEN_MECHA_PHANTOM_BEAST}
c41329458.listed_series={SET_MECHA_PHANTOM_BEAST}
function c41329458.tknfilter(c)
	return c:IsType(TYPE_TOKEN) or c:IsOriginalType(TYPE_TOKEN)
end
function c41329458.indcon(e)
	return Duel.IsExistingMatchingCard(c41329458.tknfilter,e:GetHandlerPlayer(),LOCATION_ONFIELD,0,1,nil)
end
function c41329458.rfilter(c,tp)
	return c:IsSetCard(SET_MECHA_PHANTOM_BEAST) and (c:IsControler(tp) or c:IsFaceup())
end
function c41329458.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroupCost(tp,c41329458.rfilter,2,false,aux.ReleaseCheckMMZ,nil,tp) end
	local g=Duel.SelectReleaseGroupCost(tp,c41329458.rfilter,2,2,false,aux.ReleaseCheckMMZ,nil,tp)
	Duel.Release(g,REASON_COST)
end
function c41329458.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,c,1,tp,0)
end
function c41329458.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c41329458.cfilter(c)
	return c:IsSetCard(SET_MECHA_PHANTOM_BEAST) and c:IsMonster() and c:IsDiscardable()
end
function c41329458.spcost2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c41329458.cfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,c41329458.cfilter,1,1,REASON_COST|REASON_DISCARD)
end
function c41329458.sptg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,TOKEN_MECHA_PHANTOM_BEAST,SET_MECHA_PHANTOM_BEAST,TYPES_TOKEN,0,0,3,RACE_MACHINE,ATTRIBUTE_WIND) end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,tp,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,0)
end
function c41329458.spop2(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,TOKEN_MECHA_PHANTOM_BEAST,SET_MECHA_PHANTOM_BEAST,TYPES_TOKEN,0,0,3,RACE_MACHINE,ATTRIBUTE_WIND) then
		local token=Duel.CreateToken(tp,TOKEN_MECHA_PHANTOM_BEAST)
		Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP)
	end
end