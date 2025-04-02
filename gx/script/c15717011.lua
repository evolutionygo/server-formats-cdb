--融合呪印生物－光
--The Light - Hex-Sealed Fusion
function c15717011.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetDescription(aux.Stringc15717011(c15717011,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetLabel(0)
	e1:SetCost(c15717011.cost)
	e1:SetTarget(c15717011.target)
	e1:SetOperation(c15717011.operation)
	c:RegisterEffect(e1)
	--fusion substitute
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_FUSION_SUBSTITUTE)
	e2:SetCondition(c15717011.subcon)
	c:RegisterEffect(e2)
end
function c15717011.subcon(e)
	return e:GetHandler():IsLocation(0x1e)
end
function c15717011.filter(c,e,tp,m,gc,chkf)
	return c:IsType(TYPE_FUSION) and c:IsAttribute(ATTRIBUTE_LIGHT)
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and c:CheckFusionMaterial(m,gc,chkf)
end
function c15717011.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(1)
	return true
end
function c15717011.fil(c,tp)
	return c:IsCanBeFusionMaterial(nil,MATERIAL_FUSION) and c:IsHasEffect(EFFECT_EXTRA_RELEASE_NONSUM)
		and c:IsReleasable()
end
function c15717011.fil2(c)
	return c:IsCanBeFusionMaterial(nil,MATERIAL_FUSION) and c:IsReleasable()
end
function c15717011.fcheck(mg)
	return function(tp,sg,fc)
		return #(sg&mg)<2
	end
end
function c15717011.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local chkf=tp|FUSPROC_NOTFUSION
	if chk==0 then
		if e:GetLabel()~=1 or not c:IsReleasable() then return false end
		e:SetLabel(0)
		local mg=Duel.GetMatchingGroup(c15717011.fil2,tp,LOCATION_MZONE,0,nil)
		local mg2=Duel.GetMatchingGroup(c15717011.fil,tp,0,LOCATION_MZONE,nil,tp)
		Fusion.CheckAdditional=c15717011.fcheck(mg2)
		local res=Duel.IsExistingMatchingCard(c15717011.filter,tp,LOCATION_EXTRA,0,1,nil,e,tp,mg+mg2,c,chkf)
		Fusion.CheckAdditional=nil
		return res
	end
	local mg=Duel.GetMatchingGroup(c15717011.fil2,tp,LOCATION_MZONE,0,nil)
	local mg2=Duel.GetMatchingGroup(c15717011.fil,tp,0,LOCATION_MZONE,nil,tp)
	Fusion.CheckAdditional=c15717011.fcheck(mg2)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c15717011.filter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp,mg+mg2,c,chkf)
	local mat=Duel.SelectFusionMaterial(tp,g:GetFirst(),mg+mg2,c,chkf)
	Fusion.CheckAdditional=nil
	if #(mat&mg2)>0 then
		local eff=(mat&mg2):GetFirst():IsHasEffect(EFFECT_EXTRA_RELEASE_NONSUM)
		if eff then
			eff:UseCountLimit(tp,1)
			Duel.Hint(HINT_CARD,0,eff:GetHandler():GetCode())
		end
	end
	Duel.Release(mat,REASON_COST)
	e:SetLabel(g:GetFirst():GetCode())
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c15717011.filter2(c,e,tp,code,rp)
	return c:IsCode(code) and Duel.GetLocationCountFromEx(tp,rp,nil,c)>0 and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c15717011.operation(e,tp,eg,ep,ev,re,r,rp)
	local code=e:GetLabel()
	local tc=Duel.GetFirstMatchingCard(c15717011.filter2,tp,LOCATION_EXTRA,0,nil,e,tp,code,rp)
	if tc then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end