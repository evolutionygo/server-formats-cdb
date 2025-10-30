local cm,m=GetID()
cm.name="焰魔神 蝇魔"
function cm.initial_effect(c)
	--Special Summon Procedure
	RD.AddHandSpecialSummonProcedure(c,aux.Stringid(m,0),cm.spcon,cm.sptg,cm.spop)
	--Special Summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(m,1))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_GRAVE_SPSUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(RD.ConditionSummonOrSpecialSummonMainPhase)
	e1:SetTarget(cm.target)
	e1:SetOperation(cm.operation)
	c:RegisterEffect(e1)
end
--Special Summon Procedure
function cm.spconfilter(c)
	return c:IsAbleToGraveAsCost()
end
function cm.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(cm.spconfilter,tp,LOCATION_HAND,0,2,e:GetHandler())
end
function cm.sptg(e,tp,eg,ep,ev,re,r,rp,chk,c)
	local mg=Duel.GetMatchingGroup(cm.spconfilter,tp,LOCATION_HAND,0,e:GetHandler())
	local sg=RD.Select(HINTMSG_TOGRAVE,tp,mg,nil,true,2,2)
	if sg and sg:GetCount()==2 then
		sg:KeepAlive()
		e:SetLabelObject(sg)
		return true
	else
		return false
	end
end
function cm.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=e:GetLabelObject()
	Duel.SendtoGrave(g,REASON_SPSUMMON)
	g:DeleteGroup()
end
--Special Summon
function cm.spfilter(c,e,tp)
	return c:IsLevel(10) and c:IsAttribute(ATTRIBUTE_FIRE) and c:IsRace(RACE_FIEND)
		and not c:IsAttack(2400) and RD.IsCanBeSpecialSummoned(c,e,tp,POS_FACEUP_DEFENSE)
end
function cm.posfilter(c,e,tp)
	return c:IsFaceup() and c:IsType(TYPE_RITUAL) and RD.IsCanChangePosition(c,e,tp,REASON_EFFECT)
end
function cm.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetMZoneCount(tp)>0
		and Duel.IsExistingMatchingCard(cm.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE)
end
function cm.operation(e,tp,eg,ep,ev,re,r,rp)
	if RD.SelectAndSpecialSummon(aux.NecroValleyFilter(cm.spfilter),tp,LOCATION_GRAVE,0,1,1,nil,e,POS_FACEUP_DEFENSE)~=0 then
		local posfilter=RD.Filter(cm.posfilter,e,tp)
		RD.CanSelectAndDoAction(aux.Stringid(m,2),HINTMSG_POSCHANGE,posfilter,tp,LOCATION_MZONE,0,1,1,nil,function(sg)
			Duel.BreakEffect()
			RD.ChangePosition(sg,e,tp,REASON_EFFECT)
		end)
	end
end