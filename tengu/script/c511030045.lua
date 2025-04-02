--機塊テスト (Anime)
--Appliancer Test (Anime)
--Scripted by pyrQ
function c511030045.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,c:Alias(),EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c511030045.target)
	e1:SetOperation(c511030045.activate)
	c:RegisterEffect(e1)
end
c511030045.listed_series={0x14a}
function c511030045.filter(c,e,tp)
	return c:GetSequence()>4 and c:IsSetCard(0x14a) and c:IsLinkMonster()
		and Duel.IsExistingMatchingCard(aux.NecroValleyFilter(c511030045.spfilter),tp,LOCATION_GRAVE,0,1,nil,e,tp,c)
end
function c511030045.spfilter(c,e,tp,fc)
	local zone=fc:GetToBeLinkedZone(c,tp,true)
	return c:IsSetCard(0x14a) and c:IsLinkMonster() and c:IsLink(1)
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP,tp,zone)
end
function c511030045.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c511030045.filter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c511030045.filter,tp,LOCATION_MZONE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectTarget(tp,c511030045.filter,tp,LOCATION_MZONE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,LOCATION_GRAVE)
end
function c511030045.activate(e,tp,eg,ep,ev,re,r,rp)
	local fc511030045=e:GetHandler():GetFieldID()
	local c=Duel.GetFirstTarget()
	local zone=c:GetFreeLinkedZone()&0x1f
	local count=c511030045.zone_count(zone)
	local sg=Duel.GetMatchingGroup(aux.NecroValleyFilter(c511030045.spfilter),tp,LOCATION_GRAVE,0,nil,e,tp,c)
	if #sg<count then count=#sg end
	if Duel.IsPlayerAffectedByEffect(tp,CARD_BLUEEYES_SPIRIT) then count=1 end
	if c:IsFaceup() and c:IsRelateToEffect(e) and zone~=0 then
		for i=0,count,1 do
			local g=Duel.SelectMatchingCard(tp,c511030045.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp,c)
			local tc=g:GetFirst()
			if tc then
				local zone=c:GetToBeLinkedZone(tc,tp,true)
				if zone>0 then
					Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP,zone)
					--0 ATK
					local e1=Effect.CreateEffect(e:GetHandler())
					e1:SetType(EFFECT_TYPE_SINGLE)
					e1:SetCode(EFFECT_SET_ATTACK_FINAL)
					e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
					e1:SetValue(0)
					e1:SetReset(RESET_EVENT+RESETS_STANDARD)
					tc:RegisterEffect(e1)
					tc:RegisterFlagEffect(c511030045,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,0,1)
				end
			end
		end
		Duel.SpecialSummonComplete()
		--banish them during this End Phase
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
		e2:SetCode(EVENT_PHASE+PHASE_END)
		e2:SetOperation(c511030045.rmop)
		e2:SetReset(RESET_PHASE+PHASE_END)
		e2:SetCountLimit(1)
		Duel.RegisterEffect(e2,tp)
	end
end
function c511030045.rmfilter(c)
	return c:GetFlagEffect(c511030045)>0
end
function c511030045.rmop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c511030045.rmfilter,tp,LOCATION_MZONE,0,nil)
	if #g>0 then Duel.Remove(g,POS_FACEUP,REASON_EFFECT) end
end
function c511030045.zone_count(z)
	local c=0
	while z>0 do
		c=c+1
		z=z&(z-1)
	end
	return c
end