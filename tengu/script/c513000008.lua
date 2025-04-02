--ＲＵＭ－七皇の剣 (Anime)
--Rank-Up-Magic - The Seventh One (Anime)
Duel.LoadScript("c420.lua")
function c513000008.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc513000008(c513000008,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c513000008.target)
	e1:SetOperation(c513000008.activate)
	c:RegisterEffect(e1)
end
c513000008.listed_series={SET_NUMBER}
function c513000008.tgfilter(c,e,tp,mmzone_chk)
	local no=c.aux.xyz_number
	if not (no and no>=101 and no<=107 and c:IsSetCard(SET_NUMBER) and c:IsType(TYPE_XYZ)) then return false end
	if c:IsLocation(LOCATION_MZONE) then
		return c:IsFaceup() and c:IsCanBeEffectTarget(e)
	elseif c:IsLocation(LOCATION_GRAVE) then
		return mmzone_chk and c:IsCanBeEffectTarget(e) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
	elseif c:IsLocation(LOCATION_EXTRA) then
		return Duel.GetLocationCountFromEx(tp,tp,nil,c)>0 and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
	end
end
function c513000008.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local mmzone_chk=Duel.GetLocationCount(tp,LOCATION_MZONE)>0
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE|LOCATION_GRAVE|LOCATION_EXTRA) and c513000008.tgfilter(chkc,e,tp,mmzone_chk) end
	if chk==0 then return Duel.IsExistingMatchingCard(c513000008.tgfilter,tp,LOCATION_MZONE|LOCATION_GRAVE|LOCATION_EXTRA,0,1,nil,e,tp,mmzone_chk) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local tc=Duel.SelectMatchingCard(tp,c513000008.tgfilter,tp,LOCATION_MZONE|LOCATION_GRAVE|LOCATION_EXTRA,0,1,1,nil,e,tp,mmzone_chk):GetFirst()
	Duel.SetTargetCard(tc)
	local target_not_in_mzone=not tc:IsLocation(LOCATION_MZONE)
	local g=target_not_in_mzone and tc or nil
	local ct=target_not_in_mzone and 2 or 1
	local loc=target_not_in_mzone and tc:GetLocation()|LOCATION_EXTRA or LOCATION_EXTRA
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,ct,tp,LOCATION_EXTRA)
end
function c513000008.exspfilter(c,e,tp,mc,rk)
	return c:IsC() and mc:IsCanBeXyzMaterial(c) and c:IsRank(rk) and c:IsType(TYPE_XYZ) and Duel.GetLocationCountFromEx(tp,tp,mc,c)>0
		and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_XYZ,tp,false,false)
end
function c513000008.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc:IsRelateToEffect(e) then return end
	if tc:IsLocation(LOCATION_MZONE) and (tc:IsFacedown() or tc:IsControler(1-tp)) then return end
	if tc:IsLocation(LOCATION_GRAVE|LOCATION_EXTRA) and Duel.SpecialSummonStep(tc,0,tp,tp,true,false,POS_FACEUP) then
		--Negate its effects
		tc:NegateEffects(e:GetHandler())
		if Duel.SpecialSummonComplete()==0 then return end
	end
	local pg=aux.GetMustBeMaterialGroup(tp,Group.FromCards(tc),tp,nil,nil,REASON_XYZ)
	if #pg>1 or (#pg==1 and not pg:IsContains(tc)) then return end
	local g=Duel.GetMatchingGroup(c513000008.exspfilter,tp,LOCATION_EXTRA,0,nil,e,tp,tc,tc:GetRank()+1)
	if #g>0 and Duel.SelectYesNo(tp,aux.Stringc513000008(c513000008,1)) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sc=g:Select(tp,1,1,nil):GetFirst()
		if not sc then return end
		Duel.BreakEffect()
		sc:SetMaterial(tc)
		Duel.Overlay(sc,tc)
		if Duel.SpecialSummon(sc,SUMMON_TYPE_XYZ,tp,tp,false,false,POS_FACEUP)>0 then
			sc:CompleteProcedure()
		end
	end
end