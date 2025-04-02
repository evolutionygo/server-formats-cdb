--計量機塊カッパスケール (Anime)
--Appliancer Kappa Scale (Anime)
--Scripted by pyrQ
function c511030056.initial_effect(c)
	--Link Summon
	c:EnableReviveLimit()
	Link.AddProcedure(c,c511030056.matfilter,1)
	--cannot be Link Material
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_CANNOT_BE_LINK_MATERIAL)
	e1:SetCondition(c511030056.lkcon)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--Special Summon if co-linked
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,c:Alias())
	e2:SetCondition(c511030056.spcon)
	e2:SetCost(c511030056.spcost)
	e2:SetTarget(c511030056.sptg)
	e2:SetOperation(c511030056.spop)
	e2:SetLabel(1)
	c:RegisterEffect(e2)
	--Special Summon if not co-linked
	local e3=e2:Clone()
	e3:SetCountLimit(1,{c:Alias(),1})
	e3:SetCondition(aux.NOT(c511030056.spcon))
	e3:SetLabel(0)
	c:RegisterEffect(e3)
end
c511030056.listed_series={0x14a}
function c511030056.matfilter(c,lc,sumtype,tp)
	return c:IsSetCard(0x14a,fc,sumtype,tp) and c:IsLevel(1)
end
function c511030056.lkcon(e)
	local c=e:GetHandler()
	return c:IsStatus(STATUS_SPSUMMON_TURN) and c:IsSummonType(SUMMON_TYPE_LINK)
end
function c511030056.spcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetMutualLinkedGroupCount()>0
end
function c511030056.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c511030056.spfilter(c,e,tp,colinked)
	return c:IsSetCard(0x14a) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP)
		and ((c:IsType(TYPE_LINK) and colinked) or (c:IsLevelBelow(4) and not colinked))
end
function c511030056.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local colinked=false
	if e:GetLabel()==1 then colinked=true end
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and c:IsControler(tp) and c511030056.spfilter(chkc,e,tp,colinked) end
	if chk==0 then return Duel.IsExistingTarget(c511030056.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp,colinked) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c511030056.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp,colinked)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,LOCATION_GRAVE)
end
function c511030056.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end