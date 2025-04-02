--レアメタル・ナイト
--Super Roboyarou
function c1412158.initial_effect(c)
	--Fusion Material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,true,true,92421852,38916461)
	--Increase ATK
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc1412158(c1412158,0))
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c1412158.atkcon)
	e1:SetValue(1000)
	c:RegisterEffect(e1)
	--Special Summon "Super Robolady"
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringc1412158(c1412158,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c1412158.spcon)
	e2:SetTarget(c1412158.sptg)
	e2:SetOperation(c1412158.spop)
	c:RegisterEffect(e2)
end
c1412158.listed_names={75923050}
function c1412158.atkcon(e)
	local ph=Duel.GetCurrentPhase()
	if not (ph==PHASE_DAMAGE or ph==PHASE_DAMAGE_CAL) then return false end
	local c=e:GetHandler()
	return c:IsRelateToBattle() and c:GetBattleTarget()
end
function c1412158.spcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetTurnID()~=Duel.GetTurnCount()
end
function c1412158.spfilter(c,e,tp,mc)
	return c:IsCode(75923050) and Duel.GetLocationCountFromEx(tp,tp,mc,c)>0 and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c1412158.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:GetOwner()==tp and c:IsAbleToExtra()
		and Duel.IsExistingMatchingCard(c1412158.spfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp,c) end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,c,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c1412158.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not (c:IsRelateToEffect(e) and c:IsFaceup()) then return end
	if Duel.SendtoDeck(c,nil,2,REASON_EFFECT)>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg=Duel.SelectMatchingCard(tp,c1412158.spfilter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp,c)
		if #sg==0 then return end
		Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP)
	end
end