--魂のさまよう墓場 (Manga)
--Graveyard of Wandering Souls (Manga)
--Fixed by Larry126
function c511002267.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511002267.target)
	c:RegisterEffect(e1)
	--Token
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TOKEN+CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetCondition(c511002267.spcon)
	e2:SetTarget(c511002267.sptg)
	e2:SetOperation(c511002267.spop)
	c:RegisterEffect(e2)
end
function c511002267.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local res,teg,tep,tev,tre,tr,trp=Duel.CheckEvent(EVENT_TO_GRAVE,true)
	if res and c511002267.spcon(e,tp,teg,tep,tev,tre,tr,trp) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,23116809,0,TYPES_TOKEN,100,100,1,RACE_PYRO,ATTRIBUTE_FIRE) 
		and Duel.SelectYesNo(tp,94) then
		e:SetCategory(CATEGORY_TOKEN+CATEGORY_SPECIAL_SUMMON)
		e:SetOperation(c511002267.spop)
		c511002267.sptg(e,tp,teg,tep,tev,tre,tr,trp,1)
	else
		e:SetCategory(0)
		e:SetOperation(nil)
	end
end
function c511002267.cfilter(c,tp)
	return c:GetPreviousControler()==tp and (c:IsPreviousLocation(LOCATION_HAND) and c:IsMonster()
		or c:IsPreviousLocation(LOCATION_MZONE) and c:GetPreviousTypeOnField()&TYPE_MONSTER==TYPE_MONSTER)
end
function c511002267.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511002267.cfilter,1,nil,tp)
end
function c511002267.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local ct=eg:FilterCount(c511002267.cfilter,nil,tp)
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,ct,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,ct,tp,0)
end
function c511002267.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	local ct=eg:FilterCount(c511002267.cfilter,nil,tp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>=ct
		and (not Duel.IsPlayerAffectedByEffect(tp,CARD_BLUEEYES_SPIRIT) or ct==1)
		and Duel.IsPlayerCanSpecialSummonMonster(tp,23116809,0,TYPES_TOKEN,100,100,1,RACE_PYRO,ATTRIBUTE_FIRE) then
		for i=1,ct do
			local token=Duel.CreateToken(tp,23116809)
			Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP)
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_UNRELEASABLE_SUM)
			e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e1:SetValue(1)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD)
			token:RegisterEffect(e1,true)
			local e2=e1:Clone()
			e2:SetCode(EFFECT_UNRELEASABLE_NONSUM)
			token:RegisterEffect(e2,true)
		end
		Duel.SpecialSummonComplete()
	end
end